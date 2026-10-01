#include "CompatibilityService.h"
#include <QProcess>
#include <QStandardPaths>
#include <QDir>
CompatibilityService::CompatibilityService(QObject *p):QObject(p){refresh();}
void CompatibilityService::refresh(){
 const QString wine=QStandardPaths::findExecutable("wine"); m_wineAvailable=!wine.isEmpty(); m_wineVersion.clear();
 if(m_wineAvailable){QProcess p;p.start(wine,{"--version"});if(p.waitForFinished(2000))m_wineVersion=QString::fromLocal8Bit(p.readAllStandardOutput()).trimmed();}
 m_protonPath.clear();
 for(const QString &root:{QDir::homePath()+"/.steam/steam/steamapps/common",QDir::homePath()+"/.local/share/Steam/steamapps/common"}){
  QDir d(root);const QStringList e=d.entryList({"Proton*"},QDir::Dirs);if(!e.isEmpty()){m_protonPath=d.absoluteFilePath(e.constLast());break;}
 }
 m_protonAvailable=!m_protonPath.isEmpty();emit statusChanged();
}
bool CompatibilityService::launchWithWine(const QString &exe,const QStringList &args){return m_wineAvailable&&QProcess::startDetached("wine",QStringList{exe}+args);}
bool CompatibilityService::launchWithProton(const QString &exe,const QStringList &args){if(!m_protonAvailable)return false;return QProcess::startDetached(QDir(m_protonPath).absoluteFilePath("proton"),QStringList{"run",exe}+args);}