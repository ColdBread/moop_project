import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    width: 1280
    height: 780
    property alias transactions: transactions
    property alias editAcc: editAcc
    property alias history: history
    property alias manageAuto: manageAuto

    //property alias item1: item1
    //property alias button3: button3
    property alias listView1: listView1
    property alias listModel: listModel
    property alias pane: pane
    property alias quitButton: quitButton

    //property alias labeL: button3.lAbel
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
            anchors.verticalCenterOffset: 213
            anchors.horizontalCenterOffset: 440
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            autoExclusive: false
            highlighted: true
        }

        Button {
            id: editAcc
            y: 366
            text: qsTr("Edit My Accounts")
            anchors.horizontalCenterOffset: -367
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            autoExclusive: false
            highlighted: true
        }

        Button {
            id: transactions
            x: 606
            y: 207
            text: qsTr("Transactions")
            anchors.verticalCenterOffset: -163
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true
        }

        Button {
            id: history
            x: 1024
            y: 366
            text: qsTr("History")
            anchors.horizontalCenterOffset: 436
            anchors.horizontalCenter: parent.horizontalCenter
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
            bottomPadding: 30
            topPadding: 30
            anchors.verticalCenterOffset: 1
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            /*Button {
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
            }*/
            ListView {
                id: listView1
                // Размещаем его в оставшейся части окна приложения
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                /* в данном свойстве задаём вёрстку одного объекта
                     * который будем отображать в списке в качестве одного элемента списка
                     * */
                delegate: Item {
                    id: item1

                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 40

                    // В данном элементе будет находиться одна кнопка
                    Button {
                        id: button3
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        Label {
                            id: lAbel
                            y: 17
                            text: accId
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            font.pointSize: 14
                        }

                        Label {
                            id: label2
                            x: 264
                            y: 16
                            text: accAmount
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                        }

                        /*Label {
                            id: label4
                            text: qsTr("*2288")
                            anchors.left: parent.left
                            anchors.leftMargin: 90
                            anchors.top: parent.top
                            anchors.topMargin: 5
                        }*/
                    }
                }

                // Сама модель, в которой будут содержаться все элементы
                model: ListModel {
                    id: listModel // задаём ей id для обращения
                }
            }
        }

        Button {
            id: manageAuto
            x: 606
            y: 566
            text: qsTr("Manage Auto Transactions")
            highlighted: true
            anchors.verticalCenterOffset: 213
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
