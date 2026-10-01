#pragma once
#include <QObject>
#include <QString>
class CompatibilityService final : public QObject {
 Q_OBJECT
 Q_PROPERTY(bool wineAvailable READ wineAvailable NOTIFY statusChanged)
 Q_PROPERTY(bool protonAvailable READ protonAvailable NOTIFY statusChanged)
 Q_PROPERTY(QString wineVersion READ wineVersion NOTIFY statusChanged)
 Q_PROPERTY(QString protonPath READ protonPath NOTIFY statusChanged)
public:
 explicit CompatibilityService(QObject *parent=nullptr);
 bool wineAvailable() const{return m_wineAvailable;}
 bool protonAvailable() const{return m_protonAvailable;}
 QString wineVersion() const{return m_wineVersion;}
 QString protonPath() const{return m_protonPath;}
 Q_INVOKABLE void refresh();
 Q_INVOKABLE bool launchWithWine(const QString &executable,const QStringList &arguments={});
 Q_INVOKABLE bool launchWithProton(const QString &executable,const QStringList &arguments={});
signals:void statusChanged();
private:
 bool m_wineAvailable=false,m_protonAvailable=false; QString m_wineVersion,m_protonPath;
};