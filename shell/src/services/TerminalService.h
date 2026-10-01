#pragma once

#include <QObject>
#include <QProcess>

class TerminalService final : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString workingDirectory READ workingDirectory WRITE setWorkingDirectory NOTIFY workingDirectoryChanged)

public:
    explicit TerminalService(QObject *parent = nullptr);

    QString workingDirectory() const;
    void setWorkingDirectory(const QString &path);

    Q_INVOKABLE void execute(const QString &command);
    Q_INVOKABLE void interrupt();

signals:
    void outputReady(const QString &text);
    void finished(int exitCode);
    void errorReady(const QString &text);
    void workingDirectoryChanged();

private:
    QProcess m_process;
    QString m_workingDirectory;
};