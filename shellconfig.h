#pragma once

#include <QObject>

class ShellConfig final : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString wallpaperPath READ wallpaperPath WRITE setWallpaperPath NOTIFY wallpaperPathChanged)
    Q_PROPERTY(QString wallpaperUrl READ wallpaperUrl NOTIFY wallpaperPathChanged)
    Q_PROPERTY(qreal wallpaperDim READ wallpaperDim WRITE setWallpaperDim NOTIFY wallpaperDimChanged)
    Q_PROPERTY(qreal tileOpacity READ tileOpacity WRITE setTileOpacity NOTIFY tileOpacityChanged)
    Q_PROPERTY(qreal tileBlur READ tileBlur WRITE setTileBlur NOTIFY tileBlurChanged)

public:
    explicit ShellConfig(QObject *parent = nullptr);

    QString wallpaperPath() const;
    QString wallpaperUrl() const;
    qreal wallpaperDim() const;
    qreal tileOpacity() const;
    qreal tileBlur() const;

    void setWallpaperPath(const QString &path);
    void setWallpaperDim(qreal value);
    void setTileOpacity(qreal value);
    void setTileBlur(qreal value);

signals:
    void wallpaperPathChanged();
    void wallpaperDimChanged();
    void tileOpacityChanged();
    void tileBlurChanged();

private:
    void writeSettings();

    QString m_configPath;
    QString m_wallpaperPath;
    qreal m_wallpaperDim = 0.12;
    qreal m_tileOpacity = 0.78;
    qreal m_tileBlur = 0.25;
};
