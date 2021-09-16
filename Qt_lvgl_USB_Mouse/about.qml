import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10

Window {
    id: window
    title: "About"
    width: 320; height: 240
    visible: false	//该窗口一开始默认隐藏的
    //color: "lightblue"

    Image {
        id: logo
        x: 33
        y: 96
        width: 50
        height: 48
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: tt_name.left
        source: "qrc:/lvglUSBmouse.ico"
        anchors.rightMargin: 31
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: tt_name
        text: "Qt_lvgl_USB_Mouse"
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: 20
        anchors.leftMargin: 114
        anchors.topMargin: 22
        font.family: "Times New Roman"
        font.bold: true
        anchors.verticalCenterOffset: -85
        anchors.horizontalCenterOffset: 44
        anchors.centerIn: parent
    }

    Text {
        id: tt_ver
        x: 159
        text: qsTr("Version:1.0.0")
        anchors.top: tt_name.bottom
        font.pixelSize: 14
        anchors.topMargin: 10
        font.italic: true
        minimumPixelSize: 12
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: tt_name.horizontalCenter
    }

    Text {
        id: tt_describe
        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'SimSun'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri'; font-size:8pt;\">a simple tool using PC mouse</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri'; font-size:8pt;\">to control MCU and LCD</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri'; font-size:8pt;\">(with LVGL library)</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri'; font-size:8pt;\">Created by Qt5(QtQuick)</span></p>\n<p align=\"center\" style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'SimSun','Arial','Calibri'; font-size:8pt;\"><br /></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri';\">By: </span><span style=\" font-family:'SimSun','Arial','Calibri'; font-weight:600;\">k_ying</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri';\">GitHub:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><a href=\"https://github.com/k-ying/LVGL_USB_Mouse\"><span style=\" font-family:'SimSun','Arial','Calibri'; text-decoration: underline; color:#007af4;\"><br /></span></a><span style=\" font-family:'SimSun','Arial','Calibri';\">License：GPLv3</span></p>\n<p align=\"center\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'SimSun','Arial','Calibri';\">Thanks：Qt CSDN       </span></p></body></html>"
        anchors.left: logo.right
        anchors.top: tt_name.bottom
        font.pixelSize: 13
        verticalAlignment: Text.AlignTop
        anchors.leftMargin: 23
        anchors.topMargin: 36
        anchors.horizontalCenterOffset: 0
        textFormat: Text.RichText
        font.family: "Verdana"
        font.underline: false
        anchors.horizontalCenter: tt_name.horizontalCenter

        Text {
            id: tt_tk
            text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'SimSun'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><a name=\"TaoQuick\"></a><a href=\"https://github.com/jaredtao/TaoQuick\"><span style=\" text-decoration: underline; color:#007af4;\">TaoQuick</span></a> </p></body></html>"
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 135
            anchors.topMargin: 125
            textFormat: Text.RichText
            MouseArea{
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                hoverEnabled: true
                cursorShape: containsMouse ? (pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor) : Qt.ArrowCursor
                onClicked: Qt.openUrlExternally("https://github.com/jaredtao/TaoQuick")
            }
        }
    }

    Text {
        id: tt_gh
        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'SimSun'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><a name=\"Click to jump\"></a><a href=\"https://github.com/k-ying/LVGL_USB_Mouse\"><span style=\" text-decoration: underline; color:#007af4;\">Click to jump</span></a> </p></body></html>"
        anchors.left: logo.right
        anchors.top: tt_name.bottom
        font.pixelSize: 12
        anchors.leftMargin: 114
        anchors.topMargin: 129
        textFormat: Text.RichText
        MouseArea{
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            hoverEnabled: true
            cursorShape: containsMouse ? (pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor) : Qt.ArrowCursor
            onClicked: Qt.openUrlExternally("https://github.com/k-ying/LVGL_USB_Mouse")
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}D{i:1}D{i:3}D{i:5}D{i:4}D{i:6}
}
##^##*/
