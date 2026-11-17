#include "shellconfig.h"

#include <QCoreApplication>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QSettings>
#include <QUrl>

ShellConfig::ShellConfig(QObject *parent)
    : QObject(parent)
    , m_configPath(QDir(QCoreApplication::applicationDirPath()).filePath("eternityshell.ini"))
{
    QSettings settings(m_configPath, QSettings::IniFormat);
    m_wallpaperPath = settings.value("Wallpaper/path").toString();
    m_wallpaperDim = settings.value("Wallpaper/dim", m_wallpaperDim).toReal();
    m_tileOpacity = settings.value("Tiles/opacity", m_tileOpacity).toReal();
    m_tileBlur = settings.value("Tiles/blur", m_tileBlur).toReal();

    if (!QFile::exists(m_configPath))
        writeSettings();
}

QString ShellConfig::wallpaperPath() const { return m_wallpaperPath; }
QString ShellConfig::wallpaperUrl() const
{
    QString path = m_wallpaperPath.trimmed();
    if (path.isEmpty())
        return {};

    if (path.startsWith("file://"))
        return path;

    if (path.startsWith("~/"))
        path = QDir::home().filePath(path.mid(2));
    else if (!QFileInfo(path).isAbsolute())
        path = QDir(QFileInfo(m_configPath).absolutePath()).filePath(path);

    return QUrl::fromLocalFile(QFileInfo(path).absoluteFilePath()).toString();
}
qreal ShellConfig::wallpaperDim() const { return m_wallpaperDim; }
qreal ShellConfig::tileOpacity() const { return m_tileOpacity; }
qreal ShellConfig::tileBlur() const { return m_tileBlur; }

void ShellConfig::setWallpaperPath(const QString &path)
{
    if (m_wallpaperPath == path)
        return;
    m_wallpaperPath = path;
    writeSettings();
    emit wallpaperPathChanged();
}

void ShellConfig::setWallpaperDim(qreal value)
{
    value = qBound<qreal>(0, value, 1);
    if (qFuzzyCompare(m_wallpaperDim, value))
        return;
    m_wallpaperDim = value;
    writeSettings();
    emit wallpaperDimChanged();
}

void ShellConfig::setTileOpacity(qreal value)
{
    value = qBound<qreal>(0.15, value, 1);
    if (qFuzzyCompare(m_tileOpacity, value))
        return;
    m_tileOpacity = value;
    writeSettings();
    emit tileOpacityChanged();
}

void ShellConfig::setTileBlur(qreal value)
{
    value = qBound<qreal>(0, value, 1);
    if (qFuzzyCompare(m_tileBlur, value))
        return;
    m_tileBlur = value;
    writeSettings();
    emit tileBlurChanged();
}

void ShellConfig::writeSettings()
{
    QSettings settings(m_configPath, QSettings::IniFormat);
    settings.setValue("Wallpaper/path", m_wallpaperPath);
    settings.setValue("Wallpaper/dim", m_wallpaperDim);
    settings.setValue("Tiles/opacity", m_tileOpacity);
    settings.setValue("Tiles/blur", m_tileBlur);
    settings.sync();
}
