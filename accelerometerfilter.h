#ifndef ACCELEROMETERFILTER_H
#define ACCELEROMETERFILTER_H

#include <QAccelerometerFilter>

QTM_USE_NAMESPACE

class AccelerometerFilter : public QObject, public QAccelerometerFilter
{
    Q_OBJECT

public:
    virtual bool filter(QAccelerometerReading *reading) {
        #if defined(Q_OS_SYMBIAN)
            emit readingChanged(reading->y(), -reading->x());
        #elif defined(Q_WS_MAEMO_5)
            emit readingChanged(-reading->x(), -reading->y());
        #endif

        return false;
    }

signals:
    void readingChanged(const QVariant &xacc, const QVariant &yacc);
};

#endif // ACCELEROMETERFILTER_H
