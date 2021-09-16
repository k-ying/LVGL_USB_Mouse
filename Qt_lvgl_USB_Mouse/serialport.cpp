#include "serialport.h"

SerialPort::SerialPort(QObject *parent) : QObject(parent)
{
    m_serial = new QSerialPort;
}

void SerialPort::initPort()
{
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts())
    {
        qDebug() << "Name : " << info.portName();
        emit portNameSignal(info.portName());
//        qDebug() << "Description : " << info.description();
//        qDebug() << "Manufacturer: " << info.manufacturer();
//        qDebug() << "Serial Number: " << info.serialNumber();
//        qDebug() << "System Location: " << info.systemLocation();
    }
}

bool SerialPort::serialConnect(QString port,QString baudrate,QString databits,QString parity,
                               QString stopbits)
{
    m_serial->setPortName(port);
    if(!m_serial->open(QIODevice::ReadWrite))
    {
        printf("Open Error");
        return 0;
    }

    switch (baudrate.toInt()) {
    case 4800:
        m_serial->setBaudRate(QSerialPort::Baud4800);
        break;
    case 9600:
        m_serial->setBaudRate(QSerialPort::Baud9600);
        break;
    case 115200:
        m_serial->setBaudRate(QSerialPort::Baud115200);     //设置波特率为115200
        break;
    default:
        printf("BaudRate Error");
        return 0;
    }

    switch (databits.toInt()) {
    case 6:
        m_serial->setDataBits(QSerialPort::Data6);
        break;
    case 7:
        m_serial->setDataBits(QSerialPort::Data7);
        break;
    case 8:
        m_serial->setDataBits(QSerialPort::Data8);          //设置数据位8
        break;
    default:
        printf("DataBits Error");
        return 0;
    }

    switch (parity.toInt()) {
    case 0:
        m_serial->setParity(QSerialPort::NoParity);         //校验位设置为0
        break;
    case 2:
        m_serial->setParity(QSerialPort::EvenParity);
        break;
    case 3:
        m_serial->setParity(QSerialPort::OddParity);
        break;
    default:
        printf("Parity Error");
        return 0;
    }

    switch (stopbits.toInt()) {
    case 1:
        m_serial->setStopBits(QSerialPort::OneStop);        //停止位设置为1
        break;
    case 2:
        m_serial->setStopBits(QSerialPort::TwoStop);
        break;
    case 3:
        m_serial->setStopBits(QSerialPort::OneAndHalfStop);
        break;
    default:
        printf("StopBits Error");
        return 0;
    }

    m_serial->setFlowControl(QSerialPort::NoFlowControl);//设置为无流控制
    return 1;
}

QString SerialPort::serialRead()
{
    return m_serial->readAll();
}

bool SerialPort::serialWrite(QString sendStr)
{
    if(m_serial->write(sendStr.toLatin1().data(),strlen(sendStr.toLatin1().data())))
        return 1;
    else
        return 0;
}

void SerialPort::safetyclose()
{
    if(m_serial->isOpen())
    {
        m_serial->clear();
        m_serial->close();
    }
}

SerialPort::~SerialPort()
{
    if(m_serial->isOpen())
    {
        m_serial->clear();
        m_serial->close();
    }
    m_serial->deleteLater();
}
