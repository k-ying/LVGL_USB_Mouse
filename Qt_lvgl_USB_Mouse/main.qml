import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.12
import TaoQuick 1.0
import mySerialPort 1.0

ApplicationWindow {
    id: window
    width: 640
    height: 640
    visible: true

    About{	//实例化另一个文件，文件名称第一个要大写
        id:isAbout
    }

    FontLoader{
        id: asfont_loader
        source: "fontawesome-webfont.ttf"
    }

    menuBar: MenuBar {
        Menu {
            id: menuFile
            title: qsTr("&File")
            //MenuSeparator { }
            MenuItem {
                id:menu2Quit
                font.family: "FontAwesome"
                text: "\uf08b &Quit (Ctrl+W)"
                onTriggered: Qt.quit()
                Action {
                    shortcut: "Ctrl+W"
                    onTriggered: Qt.quit()
                }
            }
        }
        Menu {
            id: menuAction
            title: qsTr("&Action")
            //Action { text: qsTr("&Start") }
            MenuItem {
                id:menu2start1stop
                font.family: "FontAwesome"
                text: bt_open1close.btnStation==false?"\uf04b &Start (Ctrl+S)":"\uf04d &Stop (Ctrl+S)"
                onTriggered: bt_open1close.clicked()
                Action {
                    shortcut: "Ctrl+S"
                    onTriggered: bt_open1close.clicked()
                }
            }
            MenuItem {
                id:menu2refresh
                font.family: "FontAwesome"
                text: "\uf021 &Refresh (Ctrl+R)"
                onTriggered: serialport.initPort()
                Action {
                    shortcut: "Ctrl+R"
                    onTriggered: serialport.initPort()
                }
            }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem {
                id:menu2about
                font.family: "FontAwesome"
                text: "\uf05a &About"
                onTriggered: isAbout.show()
            }
            //Action { text: qsTr("&About") }
        }
    }
    //FPS显示
    CusFPS {
        id: cusFPS
        x: 542
        y: 0
        width: 98
        height: 51
        anchors.right:  parent.right
        anchors.top: parent.top
    }
    //屏幕方向x
    CusSlider_Spin {
        id: lcd_x
        width: 163
        height: 80
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 35
        anchors.leftMargin: 110
        from: 1
        to:4096
        value: 160
    }
    //屏幕方向y
    CusSlider_Spin {
        id: lcd_y
        x: 365
        width: 163
        height: 80
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 110
        anchors.topMargin: 35
        from: 1
        to:4096
        value: 128
    }
    /********************************************* 串口部分 *******************************************/
    SerialPort{
        id:serialport;
    }

    Component.onCompleted: {
        serialport.portNameSignal.connect(setModel)
        serialport.initPort()
    }
    function setModel(s){
        myModel.clear() //懒得写重复检查，直接claear再append搜到的port，不clear重复刷新时会同名叠加
        myModel.append({s})
    }

    Label{
        id: tt_port
        x: 19
        text:qsTr("Port")
        anchors.right: port.left
        anchors.top: port.top
        anchors.topMargin: 13
        anchors.rightMargin: 11
    }
    ComboBox{
        id:port;
        x: 57
        y: 550
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        model: ListModel{
            id:myModel
        }//["COM1","COM2","COM3"];
    }

    Button{
        id:bt_open1close
        x: 248
        y: 551
        width: 79
        height: 40
        //text: qsTr("打开串口")
        property bool btnStation: false
        text: btnStation==false?qsTr("Start"):qsTr("Stop")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        highlighted: true
        Layout.columnSpan: 2;
        onClicked: {
            //仅由按键判断不靠谱，配合返回值控制
            if(btnStation == false)
            {
                if(serialport.serialConnect(port.currentText,"115200","8","0","1") === true)
                {
                    btnStation=!btnStation;
                }
            }
            else
            {
                serialport.safetyclose();
                btnStation=!btnStation;
            }
        }
    }

    TextField{
        id:send;
        x: 448
        y: 550
        width: 169
        height: 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 23
        anchors.bottomMargin: 50
        Layout.preferredWidth: 200
        text:if(bt_open1close.btnStation == true){
                 "X="+lcdArea.mXP+",Y="+lcdArea.mYP+","+lcdArea.mCK.toString()
             }else{"Null"}
    }

    Label {
        x: 314
        text: qsTr("Sended Text")
        anchors.right: send.left
        anchors.top: send.top
        anchors.rightMargin: 12
        anchors.topMargin: 13
    }

    Button {
        id: fresh_btn
        x: 207
        width: 34
        height: 40
        font.family: "FontAwesome"
        text: "\uf021"
        anchors.right: bt_open1close.left
        anchors.top: bt_open1close.top
        font.pointSize: 14
        anchors.topMargin: 0
        anchors.rightMargin: 7
        onClicked: serialport.initPort()
        ToolTip.visible: hovered
        ToolTip.text: "Refresh(Ctrl+R)"
        ToolTip.delay: 200
        palette {
            button: "white"
        }
    }

    Rectangle {
        id: mouse_bg
        x: 200
        y: 197
        width: lcd_x.value * 2
        height: lcd_y.value * 2
        color: "#e3e3e3"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -16
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            id: lcdArea
            anchors.fill: parent
            hoverEnabled: true
            property string mXP
            property string mYP
            property int mCK
            onPressed: {
                //鼠标按压判断
                click_wave.click(mouse.x,mouse.y)
                if(bt_open1close.btnStation == true)
                {
                    mCK = 1
                    console.log("X="+mXP+",Y="+mYP+","+mCK.toString())
                    serialport.serialWrite("X="+mXP+",Y="+mYP+","+mCK.toString()+"\r\n")
                }
            }
            onReleased: {
                //鼠标释放判断
                if(bt_open1close.btnStation == true)
                {
                    mCK = 0
                    console.log("X="+mXP+",Y="+mYP+","+mCK.toString())
                    serialport.serialWrite("X="+mXP+",Y="+mYP+","+mCK.toString()+"\r\n")
                }
            }
            onPositionChanged:  {
                //获取鼠标位置
                if(bt_open1close.btnStation == true)
                {
                    mXP = ((Array(3).join(0) + Math.round(mouseX/2)).slice(-3)).toString()
                    mYP = ((Array(3).join(0) + Math.round(mouseY/2)).slice(-3)).toString()
                    console.log("X="+mXP+",Y="+mYP+","+mCK.toString())
                    serialport.serialWrite("X="+mXP+",Y="+mYP+","+mCK.toString()+"\r\n")
                }
            }

            ClickWave{
                id: click_wave
                width: 100
                height: 100
                x:100
                y: 300
            }
        }

    }
}

