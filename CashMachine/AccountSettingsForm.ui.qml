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

    Pane {
        id: pane1
        x: 1038
        y: 290
        width: 294
        height: 352
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 433
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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

    Label {
        id: label1
        x: 940
        y: 157
        text: qsTr("Manage Your Auto Transactions")
        anchors.verticalCenterOffset: -221
        anchors.horizontalCenterOffset: 434
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 14
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

    Pane {
        id: pane
        x: 487
        y: 214
        width: 306
        height: 352
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
