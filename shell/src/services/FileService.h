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
    Q_INVOKABLE bool isDirectory(const QString &path) const;
    Q_INVOKABLE bool exists(const QString &path) const;
    Q_INVOKABLE QString parentPath(const QString &path) const;
    Q_INVOKABLE QString fileName(const QString &path) const;
    Q_INVOKABLE bool createFolder(const QString &path, const QString &name) const;
    Q_INVOKABLE bool createFile(const QString &path, const QString &name) const;
    Q_INVOKABLE bool removePath(const QString &path) const;
    Q_INVOKABLE bool renamePath(const QString &path, const QString &newName) const;
    Q_INVOKABLE bool copyPath(const QString &path, const QString &destinationDir) const;
    Q_INVOKABLE bool movePath(const QString &path, const QString &destinationDir) const;
    Q_INVOKABLE void open(const QString &path) const;
    Q_INVOKABLE bool writeText(const QString &path, const QString &text) const;
};