import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

EditAccountForm {
    Connections {
        target: appCore

        onSendEditUpdateAccInfo: {
            listModel.append({accId: id, accAmount: amount, accLimit: limit});
        }
        onSendEditRefreshAccInfo: {
            listModel.clear();
        }
    }

    backAccButton.onClicked: {
        swipeView.currentIndex = 3;
    }

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
                                id: label4
                                y: 17
                                text: accId
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 8
                                anchors.left: parent.left
                                anchors.leftMargin: 0
                                font.pointSize: 14
                            }

                            Label {
                                id: label6
                                x: 264
                                y: 16
                                text: accAmount
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                            }
                            Button {
                                id: buttonX
                                x: 326
                                y: 0
                                width: 65
                                height: 40
                                text: qsTr("X")
                                highlighted: true

                                onClicked: {
                                    appCore.receiveDeleteAcc(label4.text);
                                }
                            }


                        }
                    }

                    // Сама модель, в которой будут содержаться все элементы
                    model: ListModel {
                        id: listModel // задаём ей id для обращения
                    }
                }

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
                onClicked: {
                    appCore.receiveAddAcc();
                }
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
}
