#include "SystemService.h"

#include <QProcess>
#include <QRegularExpression>

namespace
{
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

int SystemService::volume() const
{
    return m_volume;
}

bool SystemService::networkEnabled() const
{
    return m_networkEnabled;
}

bool SystemService::bluetoothEnabled() const
{
    return m_bluetoothEnabled;
}

void SystemService::refresh()
{
    const QString audio = runCommand(QStringLiteral("wpctl"), {
        QStringLiteral("get-volume"),
        QStringLiteral("@DEFAULT_AUDIO_SINK@")
    });

    const QRegularExpression volumePattern(
        QStringLiteral(R"(Volume:\s*([0-9]+(?:\.[0-9]+)?))"));
    const auto match = volumePattern.match(audio);

    if (match.hasMatch())
        setVolumeValue(qBound(0, qRound(match.captured(1).toDouble() * 100.0), 100));

    const QString networking = runCommand(QStringLiteral("nmcli"), {
        QStringLiteral("networking")
    });

    if (networking == QStringLiteral("enabled"))
        setNetworkValue(true);
    else if (networking == QStringLiteral("disabled"))
        setNetworkValue(false);

    const QString bluetooth = runCommand(QStringLiteral("bluetoothctl"), {
        QStringLiteral("show")
    });

    if (!bluetooth.isEmpty())
        setBluetoothValue(bluetooth.contains(QStringLiteral("Powered: yes")));
}

void SystemService::setVolume(int value)
{
    value = qBound(0, value, 100);

    if (commandSucceeds(QStringLiteral("wpctl"), {
        QStringLiteral("set-volume"),
        QStringLiteral("@DEFAULT_AUDIO_SINK@"),
        QString::number(value) + QStringLiteral("%")
    })) {
        setVolumeValue(value);
    }
}

void SystemService::toggleNetwork()
{
    const bool target = !m_networkEnabled;

    if (commandSucceeds(QStringLiteral("nmcli"), {
        QStringLiteral("networking"),
        target ? QStringLiteral("on") : QStringLiteral("off")
    })) {
        setNetworkValue(target);
    }
}

void SystemService::toggleBluetooth()
{
    const bool target = !m_bluetoothEnabled;

    if (commandSucceeds(QStringLiteral("bluetoothctl"), {
        QStringLiteral("power"),
        target ? QStringLiteral("on") : QStringLiteral("off")
    })) {
        setBluetoothValue(target);
    }
}

void SystemService::toggleNightLight(bool enabled)
{
    commandSucceeds(QStringLiteral("gsettings"), {
        QStringLiteral("set"),
        QStringLiteral("org.gnome.settings-daemon.plugins.color"),
        QStringLiteral("night-light-enabled"),
        enabled ? QStringLiteral("true") : QStringLiteral("false")
    });
}

void SystemService::toggleFocus(bool enabled)
{
    commandSucceeds(QStringLiteral("gsettings"), {
        QStringLiteral("set"),
        QStringLiteral("org.gnome.desktop.notifications"),
        QStringLiteral("show-banners"),
        enabled ? QStringLiteral("false") : QStringLiteral("true")
    });
}

void SystemService::openSettings()
{
    QProcess::startDetached(QStringLiteral("gnome-control-center"));
}

void SystemService::setVolumeValue(int value)
{
    if (m_volume == value)
        return;

    m_volume = value;
    emit volumeChanged();
}

void SystemService::setNetworkValue(bool enabled)
{
    if (m_networkEnabled == enabled)
        return;

    m_networkEnabled = enabled;
    emit networkEnabledChanged();
}

void SystemService::setBluetoothValue(bool enabled)
{
    if (m_bluetoothEnabled == enabled)
        return;

    m_bluetoothEnabled = enabled;
    emit bluetoothEnabledChanged();
}
