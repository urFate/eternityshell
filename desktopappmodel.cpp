#include "desktopappmodel.h"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QProcess>
#include <QRegularExpression>
#include <QStandardPaths>
#include <QSettings>
#include <QTextStream>

#include <algorithm>

namespace {
QString valueForKey(const QHash<QString, QString> &entries, const QString &key)
{
    return entries.value(key);
}

QString findIconPath(const QString &icon)
{
    if (icon.isEmpty())
        return {};

    QFileInfo direct(icon);
    if (direct.isAbsolute() && direct.exists())
        return direct.absoluteFilePath();

    const QStringList roots = {
        "/usr/share/icons/hicolor/scalable/apps",
        "/usr/share/icons/hicolor/128x128/apps",
        "/usr/share/icons/hicolor/96x96/apps",
        "/usr/share/icons/hicolor/64x64/apps",
        "/usr/share/icons/hicolor/48x48/apps",
        "/usr/share/pixmaps"
    };

    const QStringList suffixes = {"", ".svg", ".png", ".xpm"};
    for (const QString &root : roots) {
        for (const QString &suffix : suffixes) {
            QFileInfo candidate(QDir(root).filePath(icon + suffix));
            if (candidate.exists())
                return candidate.absoluteFilePath();
        }
    }

    return {};
}

QString cleanExec(QString exec)
{
    static const QRegularExpression fieldCodes(QStringLiteral("%[fFuUdDnNickvm]")
                                                + QStringLiteral("|%%"));
    exec.replace(fieldCodes, {});
    return exec.simplified();
}

bool parseDesktopFile(const QString &path, DesktopAppModel::App &app)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    QHash<QString, QString> entries;
    QTextStream stream(&file);
    bool desktopEntry = false;
    while (!stream.atEnd()) {
        const QString line = stream.readLine();
        if (line == "[Desktop Entry]") {
            desktopEntry = true;
            continue;
        }
        if (line.startsWith('[') && line != "[Desktop Entry]") {
            if (desktopEntry)
                break;
            continue;
        }
        if (!desktopEntry || line.startsWith('#'))
            continue;

        const qsizetype separator = line.indexOf('=');
        if (separator > 0)
            entries.insert(line.left(separator), line.mid(separator + 1));
    }

    if (entries.value("Type") != "Application"
        || entries.value("Hidden") == "true"
        || entries.value("NoDisplay") == "true")
        return false;

    app.name = valueForKey(entries, "Name");
    app.exec = cleanExec(valueForKey(entries, "Exec"));
    if (app.name.isEmpty() || app.exec.isEmpty())
        return false;

    app.icon = valueForKey(entries, "Icon");
    app.iconPath = findIconPath(app.icon);
    app.desktopFile = path;
    return true;
}
}

DesktopAppModel::DesktopAppModel(QObject *parent)
    : QAbstractListModel(parent)
{
    reload();
}

int DesktopAppModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : m_apps.size();
}

QVariant DesktopAppModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_apps.size())
        return {};

    const App &app = m_apps.at(index.row());
    switch (role) {
    case NameRole: return app.name;
    case IconRole: return app.icon;
    case IconPathRole: return app.iconPath;
    case ExecRole: return app.exec;
    case DesktopFileRole: return app.desktopFile;
    default: return {};
    }
}

QHash<int, QByteArray> DesktopAppModel::roleNames() const
{
    return {
        {NameRole, "name"},
        {IconRole, "icon"},
        {IconPathRole, "iconPath"},
        {ExecRole, "exec"},
        {DesktopFileRole, "desktopFile"}
    };
}

void DesktopAppModel::launch(int row)
{
    if (row < 0 || row >= m_apps.size())
        return;

    const QString command = m_apps.at(row).exec;
    QProcess::startDetached("sh", {"-c", command});
}

void DesktopAppModel::move(int from, int to)
{
    if (from < 0 || to < 0 || from >= m_apps.size() || to >= m_apps.size() || from == to)
        return;

    beginMoveRows({}, from, from, {}, to > from ? to + 1 : to);
    m_apps.move(from, to);
    endMoveRows();

    QSettings settings("EternityShell", "Launcher");
    QStringList order;
    for (const App &app : m_apps)
        order.append(app.desktopFile);
    settings.setValue("desktopOrder", order);
}

QVariantMap DesktopAppModel::app(int row) const
{
    if (row < 0 || row >= m_apps.size())
        return {};

    const App &entry = m_apps.at(row);
    return {
        {"name", entry.name},
        {"icon", entry.icon},
        {"iconPath", entry.iconPath},
        {"row", row}
    };
}

void DesktopAppModel::reload()
{
    QList<App> apps;
    QStringList directories = {
        QDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation))
            .filePath("applications"),
        QDir::home().filePath(".local/share/applications"),
        "/usr/local/share/applications",
        "/usr/share/applications"
    };

    QSet<QString> seenNames;
    for (const QString &directory : directories) {
        const QStringList files = QDir(directory).entryList({"*.desktop"}, QDir::Files);
        for (const QString &fileName : files) {
            App app;
            const QString path = QDir(directory).filePath(fileName);
            if (!parseDesktopFile(path, app) || seenNames.contains(app.name))
                continue;
            seenNames.insert(app.name);
            apps.append(app);
        }
    }

    std::sort(apps.begin(), apps.end(), [](const App &a, const App &b) {
        return a.name.toCaseFolded() < b.name.toCaseFolded();
    });

    QSettings settings("EternityShell", "Launcher");
    const QStringList savedOrder = settings.value("desktopOrder").toStringList();
    if (!savedOrder.isEmpty()) {
        QList<App> ordered;
        for (const QString &path : savedOrder) {
            auto it = std::find_if(apps.cbegin(), apps.cend(), [&path](const App &app) {
                return app.desktopFile == path;
            });
            if (it != apps.cend()) {
                ordered.append(*it);
                apps.erase(it);
            }
        }
        ordered.append(apps);
        apps = std::move(ordered);
    }

    beginResetModel();
    m_apps = std::move(apps);
    endResetModel();
}
