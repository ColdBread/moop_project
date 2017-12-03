import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    width: 1280
    height: 780

    Background {
        id: background
        anchors.fill: parent

        Pane {
            id: pane
            x: 515
            y: 197
            width: 415
            height: 273
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: button
            x: 590
            y: 570
            text: qsTr("Add New Account ")
            highlighted: true
            anchors.verticalCenterOffset: 174
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        RoundButton {
            id: backAccButton
            x: 87
            y: 636
            text: "<"
            checkable: false
            highlighted: true
            anchors.verticalCenterOffset: 268
            anchors.horizontalCenterOffset: -536
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
