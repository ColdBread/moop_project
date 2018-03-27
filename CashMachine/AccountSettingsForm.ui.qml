import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: item1
    width: 1280
    height: 780
    property alias sendLimitButton: sendLimitButton
    property alias labelLimit: labelLimit
    property alias roundBackButton: roundBackButton
    property alias limitField: limitField

    Background {
        id: background
        anchors.fill: parent
    }

    Label {
        id: labelLimit
        x: 144
        y: 244
        text: qsTr("Change Credit Limit")
        anchors.verticalCenterOffset: -137
        anchors.horizontalCenterOffset: -414
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 14
    }

    Label {
        id: label
        x: 460
        y: 170
        text: qsTr("Your Transactions History For This Account")
        font.pointSize: 14
        anchors.verticalCenterOffset: -221
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    TextField {
        id: limitField
        x: 125
        y: 370
        text: qsTr("")
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenterOffset: -58
        anchors.horizontalCenterOffset: -414
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: sendLimitButton
        x: 172
        y: 396
        text: qsTr("Send")
        highlighted: true
        anchors.verticalCenterOffset: 36
        anchors.horizontalCenterOffset: -414
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    RoundButton {
        id: roundBackButton
        x: 77
        y: 627
        text: "<"
        anchors.verticalCenterOffset: 222
        anchors.horizontalCenterOffset: -494
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        highlighted: true
    }
}
