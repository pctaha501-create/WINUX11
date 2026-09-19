#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QProcess>
#include <QObject>

class Launcher final : public QObject
{
    Q_OBJECT

public:
    explicit Launcher(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void openTerminal()
    {
        QProcess::startDetached(QStringLiteral("x-terminal-emulator"), {});
    }

    Q_INVOKABLE void openExplorer()
    {
        QProcess::startDetached(QStringLiteral("xdg-open"),
                                 {QDir::homePath()});
    }

    Q_INVOKABLE void openBrowser()
    {
        QProcess::startDetached(QStringLiteral("xdg-open"),
                                 {QStringLiteral("https://www.google.com")});
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("WINUX11"));
    app.setApplicationDisplayName(QStringLiteral("WINUX11"));
    app.setOrganizationName(QStringLiteral("WINUX11"));

    Launcher launcher;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("launcher"), &launcher);

    engine.loadFromModule(QStringLiteral("WINUX11"), QStringLiteral("Main"));

    if (engine.rootObjects().isEmpty())
        return 1;

    return app.exec();
}

#include "main.moc"
