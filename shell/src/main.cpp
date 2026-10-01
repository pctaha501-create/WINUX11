#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QProcess>
#include <QStandardPaths>
#include <QUrl>

#include "services/SystemService.h"
#include "services/TerminalService.h"
#include "services/FileService.h"
#include "services/CalculatorService.h"

class Launcher final : public QObject
{
    Q_OBJECT
public:
    explicit Launcher(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void openTerminal()
    {
        QProcess::startDetached("x-terminal-emulator");
    }

    Q_INVOKABLE void openExplorer()
    {
        QProcess::startDetached("xdg-open", {QDir::homePath()});
    }

    Q_INVOKABLE void openBrowser()
    {
        openBrowserUrl("https://www.google.com");
    }

    Q_INVOKABLE void openBrowserUrl(QString url)
    {
        if (!url.startsWith("http://") && !url.startsWith("https://"))
            url = "https://" + url;

        const QStringList candidates = {
            "chromium",
            "chromium-browser",
            "google-chrome",
            "google-chrome-stable"
        };

        for (const QString &browser : candidates) {
            if (QStandardPaths::findExecutable(browser).isEmpty())
                continue;

            if (QProcess::startDetached(browser, {"--app=" + url, "--new-window"}))
                return;
        }

        QProcess::startDetached("xdg-open", {QUrl(url).toString()});
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("WINUX11");
    app.setApplicationDisplayName("WINUX11");
    app.setOrganizationName("WINUX11");

    Launcher launcher;
    SystemService systemService;
    TerminalService terminalService;
    FileService fileService;
    CalculatorService calculatorService;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("launcher", &launcher);
    engine.rootContext()->setContextProperty("systemService", &systemService);
    engine.rootContext()->setContextProperty("terminalService", &terminalService);
    engine.rootContext()->setContextProperty("fileService", &fileService);
    engine.rootContext()->setContextProperty("calculatorService", &calculatorService);

    engine.load(QUrl(QStringLiteral("qrc:/WINUX11-runtime/src/Main.qml")));

    if (engine.rootObjects().isEmpty())
        return 1;

    return app.exec();
}

#include "main.moc"
