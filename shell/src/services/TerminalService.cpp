#include "TerminalService.h"

#include <QDir>
#include <QStandardPaths>

TerminalService::TerminalService(QObject *parent)
    : QObject(parent),
      m_workingDirectory(QDir::homePath())
{
    m_process.setProcessChannelMode(QProcess::MergedChannels);

    connect(&m_process, &QProcess::readyReadStandardOutput, this, [this]() {
        const QString text = QString::fromLocal8Bit(m_process.readAllStandardOutput());
        if (!text.isEmpty())
            emit outputReady(text);
    });

    connect(&m_process, &QProcess::finished, this,
            [this](int exitCode, QProcess::ExitStatus) {
        emit finished(exitCode);
    });

    connect(&m_process, &QProcess::errorOccurred, this,
            [this](QProcess::ProcessError) {
        emit errorReady(m_process.errorString());
    });
}

QString TerminalService::workingDirectory() const
{
    return m_workingDirectory;
}

void TerminalService::setWorkingDirectory(const QString &path)
{
    const QString clean = QDir::cleanPath(path);
    if (clean.isEmpty() || !QDir(clean).exists() || clean == m_workingDirectory)
        return;

    m_workingDirectory = clean;
    emit workingDirectoryChanged();
}

void TerminalService::execute(const QString &command)
{
    const QString trimmed = command.trimmed();
    if (trimmed.isEmpty())
        return;

    if (m_process.state() != QProcess::NotRunning)
        m_process.kill();

    m_process.setWorkingDirectory(m_workingDirectory);
    m_process.startCommand(trimmed);
}

void TerminalService::interrupt()
{
    if (m_process.state() != QProcess::NotRunning)
        m_process.kill();
}