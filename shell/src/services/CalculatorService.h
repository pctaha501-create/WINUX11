#pragma once

#include <QObject>

class CalculatorService final : public QObject
{
    Q_OBJECT
public:
    explicit CalculatorService(QObject *parent = nullptr);
    Q_INVOKABLE QString evaluate(const QString &expression) const;
};