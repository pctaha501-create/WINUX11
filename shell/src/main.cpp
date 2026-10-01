#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QProcess>
#include <QDir>
#include <QUrl>
#include "services/SystemService.h"
#include "services/TerminalService.h"
#include "services/FileService.h"
#include "services/CalculatorService.h"
#include "services/CompatibilityService.h"
class Launcher:public QObject{Q_OBJECT
public:using QObject::QObject;
Q_INVOKABLE void openTerminal(){QProcess::startDetached("x-terminal-emulator");}
Q_INVOKABLE void openExplorer(){QProcess::startDetached("xdg-open",{QDir::homePath()});}
Q_INVOKABLE void openBrowser(){QProcess::startDetached("xdg-open",{"https://www.google.com"});}
Q_INVOKABLE void openBrowserUrl(QString u){if(!u.startsWith("http://")&&!u.startsWith("https://"))u="https://"+u;QProcess::startDetached("xdg-open",{u});}};
int main(int argc,char *argv[]){QGuiApplication app(argc,argv);app.setApplicationName("WINUX11");app.setApplicationDisplayName("WINUX11");
Launcher launcher;SystemService systemService;TerminalService terminalService;FileService fileService;CalculatorService calculatorService;CompatibilityService compatibilityService;
QQmlApplicationEngine engine;auto*c=engine.rootContext();c->setContextProperty("launcher",&launcher);c->setContextProperty("systemService",&systemService);c->setContextProperty("terminalService",&terminalService);c->setContextProperty("fileService",&fileService);c->setContextProperty("calculatorService",&calculatorService);c->setContextProperty("compatibilityService",&compatibilityService);
engine.load(QUrl("qrc:/qt/qml/WINUX11/Main.qml"));if(engine.rootObjects().isEmpty())return 1;return app.exec();}
#include "main.moc"