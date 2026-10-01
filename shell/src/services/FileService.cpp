#include "FileService.h"

#include <QDir>
#include <QFile>
#include <QProcess>
#include <QStandardPaths>

FileService::FileService(QObject *parent)
    : QObject(parent)
{
}

QString FileService::homePath() const
{
    return QDir::homePath();
}

QStringList FileService::list(const QString &path) const
{
    QDir dir(path);
    return dir.entryList(QDir::NoDotAndDotDot | QDir::AllEntries,
                         QDir::DirsFirst | QDir::Name);
}

void FileService::open(const QString &path) const
{
    QProcess::startDetached(QStringLiteral("xdg-open"), {path});
}

bool FileService::writeText(const QString &path, const QString &text) const
{
    QString target = path;
    if (!target.startsWith('/'))
        target = QDir::homePath() + QStringLiteral("/") + target;

    QFile file(target);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    file.write(text.toUtf8());
    return true;
}