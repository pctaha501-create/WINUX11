#include "CalculatorService.h"

#include <QJSEngine>

CalculatorService::CalculatorService(QObject *parent)
    : QObject(parent)
{
}

QString CalculatorService::evaluate(const QString &expression) const
{
    QJSEngine engine;
    const QJSValue result = engine.evaluate(expression);
    if (result.isError())
        return QStringLiteral("Error");

    return result.toString();
}