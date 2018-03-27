import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: item1
    width: 1280
    height: 780
    property alias comboAccs: comboAccs
    property alias textDestination: textDestination
    property alias switchRegular: switchRegular
    property alias textPeriod: textPeriod
    property alias submit: submit
    property alias roundButtonBack: roundButtonBack

    Background {
        id: background
        anchors.fill: parent
    }

    ComboBox {
        id: comboAccs
        x: 504
        width: 272
        height: 48
        anchors.verticalCenterOffset: -162
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: label
        x: 504
        width: 179
        height: 40
        text: qsTr("Choose Your Account")
        anchors.verticalCenterOffset: -230
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
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
        anchors.verticalCenterOffset: -90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 14
    }

    TextField {
        id: textDestination
        x: 504
        y: 370
        width: 272
        height: 40
        anchors.verticalCenterOffset: 5
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Switch {
        id: switchRegular
        x: 503
        y: 455
        text: qsTr("Regural")
        anchors.verticalCenterOffset: 79
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -72
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

    TextField {
        id: textPeriod
        x: 668
        y: 463
        width: 61
        height: 43
        horizontalAlignment: Text.AlignRight
        enabled: false
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
