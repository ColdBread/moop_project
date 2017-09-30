import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    width: 1280
    height: 780

    Rectangle {
        id: rectangle
        color: "#009688"
        anchors.fill: parent

        Pane {
            id: pane
            x: 540
            y: 290
            width: 424
            height: 508
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            GroupBox {
                id: groupBox
                title: qsTr("Login")
                font.bold: true
                font.pointSize: 20
                anchors.fill: parent



                TextField {
                    id: phoneField
                    x: 58
                    y: 43
                    width: 260
                    height: 41
                    anchors.verticalCenterOffset: -147
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 12
                }

                TextField {
                    id: passwordField
                    x: 58
                    y: 116
                    width: 260
                    height: 41
                    anchors.verticalCenterOffset: -48
                    anchors.horizontalCenterOffset: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 12
                }

                Button {
                    id: loginButton
                    x: 138
                    y: 227
                    text: qsTr("Login")
                    anchors.verticalCenterOffset: 28
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 12
                    highlighted: true
                }

                Label {
                    id: passwordLabel
                    x: 58
                    y: 117
                    text: qsTr("Password")
                    font.bold: false
                    font.pointSize: 12
                }

                Label {
                    id: phoneNumberLabel
                    x: 58
                    y: 18
                    text: qsTr("Phone Number")
                    font.bold: false
                    font.pointSize: 12
                }
            }
        }
    }
}
