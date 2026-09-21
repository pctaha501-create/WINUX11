#pragma once

#include <QObject>

class SystemService final : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int volume READ volume NOTIFY volumeChanged)
    Q_PROPERTY(bool networkEnabled READ networkEnabled NOTIFY networkEnabledChanged)
    Q_PROPERTY(bool bluetoothEnabled READ bluetoothEnabled NOTIFY bluetoothEnabledChanged)

public:
    explicit SystemService(QObject *parent = nullptr);

    int volume() const;
    bool networkEnabled() const;
    bool bluetoothEnabled() const;

    Q_INVOKABLE void setVolume(int value);
    Q_INVOKABLE void toggleNetwork();
    Q_INVOKABLE void toggleBluetooth();
    Q_INVOKABLE void toggleNightLight(bool enabled);
    Q_INVOKABLE void toggleFocus(bool enabled);
    Q_INVOKABLE void openSettings();
    Q_INVOKABLE void refresh();

signals:
    void volumeChanged();
    void networkEnabledChanged();
    void bluetoothEnabledChanged();

private:
    int m_volume = 40;
    bool m_networkEnabled = true;
    bool m_bluetoothEnabled = false;

    void setVolumeValue(int value);
    void setNetworkValue(bool enabled);
    void setBluetoothValue(bool enabled);
};
