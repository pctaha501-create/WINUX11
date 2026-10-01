#include "SystemService.h"
#include <QProcess>
#include <QRegularExpression>
#include <QtMath>
namespace {
QString runCommand(const QString &program, const QStringList &arguments) { QProcess p; p.start(program, arguments); if (!p.waitForFinished(2000)) { p.kill(); p.waitForFinished(500); return {}; } return QString::fromLocal8Bit(p.readAllStandardOutput()).trimmed(); }
bool commandSucceeds(const QString &program, const QStringList &arguments) { QProcess p; p.start(program, arguments); if (!p.waitForFinished(2500)) { p.kill(); p.waitForFinished(500); return false; } return p.exitStatus() == QProcess::NormalExit && p.exitCode() == 0; }
}
SystemService::SystemService(QObject *parent):QObject(parent){refresh();}
int SystemService::volume() const{return m_volume;}
bool SystemService::networkEnabled() const{return m_networkEnabled;}
bool SystemService::bluetoothEnabled() const{return m_bluetoothEnabled;}
QString SystemService::commandOutput(const QString &program,const QStringList &arguments) const{return runCommand(program,arguments);}
bool SystemService::commandSuccess(const QString &program,const QStringList &arguments) const{return commandSucceeds(program,arguments);}
bool SystemService::launchCommand(const QString &program,const QStringList &arguments) const{return QProcess::startDetached(program,arguments);}
void SystemService::refresh(){const QString a=runCommand("wpctl",{"get-volume","@DEFAULT_AUDIO_SINK@"}); const QRegularExpression re(QStringLiteral("Volume:\\s*([0-9]+(?:\\.[0-9]+)?)")); const auto m=re.match(a); if(m.hasMatch())setVolumeValue(qBound(0,qRound(m.captured(1).toDouble()*100.0),100)); const QString n=runCommand("nmcli",{"networking"}); if(n=="enabled")setNetworkValue(true); if(n=="disabled")setNetworkValue(false); const QString b=runCommand("bluetoothctl",{"show"}); if(!b.isEmpty())setBluetoothValue(b.contains("Powered: yes"));}
void SystemService::setVolume(int value){value=qBound(0,value,100);if(commandSucceeds("wpctl",{"set-volume","@DEFAULT_AUDIO_SINK@",QString::number(value/100.0,'f',2)}))setVolumeValue(value);}
void SystemService::toggleNetwork(){const bool t=!m_networkEnabled;if(commandSucceeds("nmcli",{"networking",t?"on":"off"}))setNetworkValue(t);}
void SystemService::toggleBluetooth(){const bool t=!m_bluetoothEnabled;if(commandSucceeds("bluetoothctl",{"power",t?"on":"off"}))setBluetoothValue(t);}
void SystemService::toggleNightLight(bool e){commandSucceeds("gsettings",{"set","org.gnome.settings-daemon.plugins.color","night-light-enabled",e?"true":"false"});}
void SystemService::toggleFocus(bool e){commandSucceeds("gsettings",{"set","org.gnome.desktop.notifications","show-banners",e?"false":"true"});}
void SystemService::openSettings(){QProcess::startDetached("gnome-control-center");}
QString SystemService::processSnapshot() const{const QString t=runCommand("ps",{"-eo","pid,comm,%cpu,%mem","--sort=-%cpu"});if(t.isEmpty())return QStringLiteral("Unable to read process table.");const QStringList l=t.split('\n');return l.mid(0,qMin(24,l.size())).join('\n');}
void SystemService::setVolumeValue(int v){if(m_volume!=v){m_volume=v;emit volumeChanged();}}
void SystemService::setNetworkValue(bool v){if(m_networkEnabled!=v){m_networkEnabled=v;emit networkEnabledChanged();}}
void SystemService::setBluetoothValue(bool v){if(m_bluetoothEnabled!=v){m_bluetoothEnabled=v;emit bluetoothEnabledChanged();}}
