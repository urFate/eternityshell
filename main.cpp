#include <QGuiApplication>
#include <QFont>
#include <QFontDatabase>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "desktopappmodel.h"
#include "shellconfig.h"

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_PLATFORM", "xcb");
    //qputenv("QT_XCB_GL_INTEGRATION", "xcb_egl");
    QGuiApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QGuiApplication app(argc, argv);

    const QStringList fontFiles = {
        ":/qt/qml/eternityshell/font/Ubuntu-Regular.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-Light.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-Medium.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-Bold.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-Italic.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-LightItalic.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-MediumItalic.ttf",
        ":/qt/qml/eternityshell/font/Ubuntu-BoldItalic.ttf"
    };

    for (const QString &fontFile : fontFiles)
        QFontDatabase::addApplicationFont(fontFile);

    app.setFont(QFont("Ubuntu"));

    DesktopAppModel desktopApps;
    ShellConfig shellConfig;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("desktopApps", &desktopApps);
    engine.rootContext()->setContextProperty("shellConfig", &shellConfig);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("eternityshell", "Main");

    return QGuiApplication::exec();
}
