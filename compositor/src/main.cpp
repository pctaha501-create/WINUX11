#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCoreApplication>
#include <QString>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("WINUX11 Compositor"));
    app.setApplicationDisplayName(QStringLiteral("WINUX11"));
    app.setOrganizationName(QStringLiteral("WINUX11"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qt/qml/WINUX11/Compositor/Main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        [] { QCoreApplication::exit(1); },
        Qt::QueuedConnection);

    engine.load(url);
    if (engine.rootObjects().isEmpty())
        return 1;

    return app.exec();
}
