#include "FileService.h"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QProcess>
#include <QStandardPaths>

FileService::FileService(QObject *parent) : QObject(parent) {}

QString FileService::homePath() const { return QDir::homePath(); }

QStringList FileService::list(const QString &path) const
{
    QDir dir(path);
    if (!dir.exists())
        return {};
    return dir.entryList(QDir::NoDotAndDotDot | QDir::AllEntries | QDir::Hidden,
                         QDir::DirsFirst | QDir::Name);
}

bool FileService::isDirectory(const QString &path) const { return QFileInfo(path).isDir(); }
bool FileService::exists(const QString &path) const { return QFileInfo::exists(path); }
QString FileService::parentPath(const QString &path) const { return QFileInfo(path).dir().absolutePath(); }
QString FileService::fileName(const QString &path) const { return QFileInfo(path).fileName(); }

bool FileService::createFolder(const QString &path, const QString &name) const
{
    return QDir(path).mkpath(name);
}

bool FileService::createFile(const QString &path, const QString &name) const
{
    QDir dir(path);
    if (!dir.exists() && !dir.mkpath("."))
        return false;
    QFile file(dir.filePath(name));
    return file.open(QIODevice::WriteOnly) && file.close();
}

bool FileService::removePath(const QString &path) const
{
    QFileInfo info(path);
    if (!info.exists() || path == QDir::homePath())
        return false;
    if (info.isDir())
        return QDir(path).removeRecursively();
    return QFile::remove(path);
}

bool FileService::renamePath(const QString &path, const QString &newName) const
{
    QFileInfo info(path);
    if (!info.exists() || newName.isEmpty() || newName.contains('/'))
        return false;
    return QDir(info.absolutePath()).rename(info.fileName(), newName);
}

bool FileService::copyPath(const QString &path, const QString &destinationDir) const
{
    QFileInfo src(path);
    QDir dst(destinationDir);
    if (!src.exists() || !dst.exists())
        return false;
    const QString target = dst.filePath(src.fileName());
    if (src.isDir()) {
        if (!QDir().mkpath(target))
            return false;
        QDir sourceDir(path);
        for (const QString &entry : sourceDir.entryList(QDir::NoDotAndDotDot | QDir::AllEntries | QDir::Hidden)) {
            if (!copyPath(sourceDir.filePath(entry), target))
                return false;
        }
        return true;
    }
    return QFile::copy(path, target);
}

bool FileService::movePath(const QString &path, const QString &destinationDir) const
{
    QFileInfo src(path);
    QDir dst(destinationDir);
    if (!src.exists() || !dst.exists())
        return false;
    if (QDir().rename(path, dst.filePath(src.fileName())))
        return true;
    if (!copyPath(path, destinationDir))
        return false;
    return removePath(path);
}

void FileService::open(const QString &path) const
{
    if (QFileInfo::exists(path))
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
    return file.write(text.toUtf8()) >= 0;
}