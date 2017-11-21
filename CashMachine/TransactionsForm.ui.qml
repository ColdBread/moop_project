import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: item1
    width: 1280
    height: 780
    property alias submit: submit
    property alias roundButtonBack: roundButtonBack

    Background {
        id: background
        anchors.fill: parent

        /* ComboBox {
            id: comboBox
            x: 504
            width: 273
            height: 40
            anchors.top: parent.top
            anchors.topMargin: 262
            anchors.horizontalCenter: parent.horizontalCenter
            currentIndex: 0
            model: ["Account 1", "Account 2", "Account 3"]
        }*/
    }

    ComboBox {
        id: comboBox
        x: 504
        width: 272
        height: 48
        anchors.top: parent.top
        anchors.topMargin: 262
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: label
        x: 504
        width: 179
        height: 40
        text: qsTr("Choose Your Account")
        anchors.horizontalCenterOffset: -46
        anchors.top: parent.top
        anchors.topMargin: 216
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 14
    }

    Label {
        id: label1
        x: 504
        y: 340
        width: 217
        height: 24
        text: qsTr("Enter Destination Account")
        anchors.horizontalCenterOffset: -27
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 416
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 14
    }

    TextField {
        id: textField
        x: 504
        y: 370
        width: 272
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 370
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Switch {
        id: switch1
        x: 503
        y: 455
        text: qsTr("Pay Monthly")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 285
        anchors.horizontalCenterOffset: -49
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 14
    }

    RoundButton {
        id: roundButtonBack
        y: 675
        text: "<"
        highlighted: true
        anchors.left: parent.left
        anchors.leftMargin: 62
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 65
    }

    Button {
        id: submit
        x: 590
        y: 550
        text: qsTr("Submit")
        highlighted: true
        font.pointSize: 14
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 190
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
