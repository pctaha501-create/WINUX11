#include "SystemService.h"

#include <QProcess>
#include <QRegularExpression>

namespace {
QString runCommand(const QString &program, const QStringList &arguments)
{
    QProcess process;
    process.start(program, arguments);
    if (!process.waitForFinished(1500))
        return {};
    return QString::fromLocal8Bit(process.readAllStandardOutput()).trimmed();
}

bool commandSucceeds(const QString &program, const QStringList &arguments)
{
    QProcess process;
    process.start(program, arguments);
    if (!process.waitForFinished(2000))
        return false;
    return process.exitStatus() == QProcess::NormalExit && process.exitCode() == 0;
}
}

SystemService::SystemService(QObject *parent)
    : QObject(parent)
{
    refresh();
}

int SystemService::volume() const { return m_volume; }
bool SystemService::networkEnabled() const { return m_networkEnabled; }
bool SystemService::bluetoothEnabled() const { return m_bluetoothEnabled; }

void SystemService::refresh()
{
    const QString audio = runCommand("wpctl", {"get-volume", "@DEFAULT_AUDIO_SINK@"});
    const QRegularExpression pattern(QStringLiteral(R"(Volume:\s*([0-9]+(?:\.[0-9]+)?))"));
    const auto match = pattern.match(audio);
    if (match.hasMatch())
        setVolumeValue(qBound(0, qRound(match.captured(1).toDouble() * 100.0), 100));

    const QString networking = runCommand("nmcli", {"networking"});
    if (networking == "enabled") setNetworkValue(true);
    if (networking == "disabled") setNetworkValue(false);

    const QString bluetooth = runCommand("bluetoothctl", {"show"});
    if (!bluetooth.isEmpty())
        setBluetoothValue(bluetooth.contains("Powered: yes"));
}

void SystemService::setVolume(int value)
{
    value = qBound(0, value, 100);
    if (commandSucceeds("wpctl", {"set-volume", "@DEFAULT_AUDIO_SINK@", QString::number(value) + "%"}))
        setVolumeValue(value);
}

void SystemService::toggleNetwork()
{
    const bool target = !m_networkEnabled;
    if (commandSucceeds("nmcli", {"networking", target ? "on" : "off"}))
        setNetworkValue(target);
}

void SystemService::toggleBluetooth()
{
    const bool target = !m_bluetoothEnabled;
    if (commandSucceeds("bluetoothctl", {"power", target ? "on" : "off"}))
        setBluetoothValue(target);
}

void SystemService::toggleNightLight(bool enabled)
{
    commandSucceeds("gsettings", {"set", "org.gnome.settings-daemon.plugins.color",
                                  "night-light-enabled", enabled ? "true" : "false"});
}

void SystemService::toggleFocus(bool enabled)
{
    commandSucceeds("gsettings", {"set", "org.gnome.desktop.notifications",
                                  "show-banners", enabled ? "false" : "true"});
}

void SystemService::openSettings()
{
    QProcess::startDetached("gnome-control-center");
}

QString SystemService::processSnapshot() const
{
    QProcess process;
    process.start("ps", {"-eo", "pid,comm,%cpu,%mem", "--sort=-%cpu"});
    if (!process.waitForFinished(1200))
        return QStringLiteral("Unable to read process table.");

    QString text = QString::fromLocal8Bit(process.readAllStandardOutput());
    const QStringList lines = text.split('\n');
    return lines.mid(0, qMin(18, lines.size())).join('\n');
}

void SystemService::setVolumeValue(int value)
{
    if (m_volume == value) return;
    m_volume = value;
    emit volumeChanged();
}

void SystemService::setNetworkValue(bool enabled)
{
    if (m_networkEnabled == enabled) return;
    m_networkEnabled = enabled;
    emit networkEnabledChanged();
}

void SystemService::setBluetoothValue(bool enabled)
{
    if (m_bluetoothEnabled == enabled) return;
    m_bluetoothEnabled = enabled;
    emit bluetoothEnabledChanged();
}