import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    width: 1280
    height: 780
    property alias button1: button1
    property alias quitButton: quitButton

    Background {
        id: background
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Label {
            id: label
            x: 518
            y: 146
            text: qsTr("Welcome To E-banking")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -231
            anchors.verticalCenter: parent.verticalCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Button {
            id: quitButton
            x: 1125
            y: 647
            text: qsTr("Quit")
            anchors.right: parent.right
            anchors.rightMargin: 91
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 85
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            autoExclusive: false
            highlighted: true
        }

        Label {
            id: label1
            x: 541
            y: 210
            width: 198
            height: 51
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 18
        }

        Button {
            id: button
            y: 366
            text: qsTr("Edit My Accounts")
            anchors.left: parent.left
            anchors.leftMargin: 182
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            autoExclusive: false
            highlighted: true
        }

        Button {
            id: button1
            x: 606
            y: 647
            text: qsTr("Transactions")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 85
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true
        }

        Button {
            id: button2
            x: 1024
            y: 366
            text: qsTr("History")
            anchors.right: parent.right
            anchors.rightMargin: 183
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            highlighted: true
        }

        Pane {
            id: pane
            x: 500
            y: 290
            width: 324
            height: 177
            anchors.verticalCenterOffset: 1
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Button {
                id: button3
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top

                Label {
                    id: label2
                    x: 264
                    y: 16
                    text: qsTr("20.50")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                Label {
                    id: label3
                    y: 17
                    text: qsTr("Account 1")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.pointSize: 14
                }

                Label {
                    id: label4
                    text: qsTr("*2288")
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.top: parent.top
                    anchors.topMargin: 5
                }
            }

            Button {
                id: button4
                y: 54
                height: 48
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0

                Label {
                    id: label5
                    x: 264
                    y: 16
                    text: qsTr("120.00")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                Label {
                    id: label6
                    y: 17
                    text: qsTr("Account 2")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    font.pointSize: 14
                    anchors.bottomMargin: 8
                }

                Label {
                    id: label7
                    text: qsTr("*2289")
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.topMargin: 5
                }
            }

            Button {
                id: button5
                y: 108
                height: 48
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0

                Label {
                    id: label8
                    x: 264
                    y: 16
                    text: qsTr("-40.20")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                Label {
                    id: label9
                    y: 17
                    text: qsTr("Account 3")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    font.pointSize: 14
                    anchors.bottomMargin: 8
                }

                Label {
                    id: label10
                    text: qsTr("*2290")
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.topMargin: 5
                }
            }
        }
    }
}
