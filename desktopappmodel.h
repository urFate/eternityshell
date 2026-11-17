#pragma once

#include <QAbstractListModel>

class DesktopAppModel final : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Role {
        NameRole = Qt::UserRole + 1,
        IconRole,
        IconPathRole,
        ExecRole,
        DesktopFileRole
    };

    explicit DesktopAppModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void launch(int row);
    Q_INVOKABLE QVariantMap app(int row) const;
    Q_INVOKABLE void move(int from, int to);
    Q_INVOKABLE void reload();

    struct App {
        QString name;
        QString icon;
        QString iconPath;
        QString exec;
        QString desktopFile;
    };

private:
    QList<App> m_apps;
};
