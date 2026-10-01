#pragma once

#include <QObject>
#include <QStringList>

class FileService final : public QObject
{
    Q_OBJECT
public:
    explicit FileService(QObject *parent = nullptr);

    Q_INVOKABLE QString homePath() const;
    Q_INVOKABLE QStringList list(const QString &path) const;
    Q_INVOKABLE void open(const QString &path) const;
    Q_INVOKABLE bool writeText(const QString &path, const QString &text) const;
};