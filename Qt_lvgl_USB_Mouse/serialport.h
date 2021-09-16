#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>

class SerialPort : public QObject
{
    Q_OBJECT
public:
    explicit SerialPort(QObject *parent = nullptr);
    ~SerialPort();

    Q_INVOKABLE bool serialConnect(QString port,QString baudrate,QString databits,QString parity,QString stopbits);
    Q_INVOKABLE QString serialRead();
    Q_INVOKABLE bool serialWrite(QString sendStr);
    Q_INVOKABLE void safetyclose();

signals:
    void portNameSignal(QString portName);

public slots:
    void initPort();

private:
    QSerialPort *m_serial;
};

#endif // SERIALPORT_H
