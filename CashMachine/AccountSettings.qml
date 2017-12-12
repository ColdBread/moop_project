import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

AccountSettingsForm {

    Connections {
        target: appCore

        /*onSendEditUpdateAccInfo: {
            listModel.append({accId: id, accAmount: amount, accLimit: limit});
        }
        onSendEditRefreshAccInfo: {
            listModel.clear();
        }*/
        onSendSettingsUpdateAccInfo: {
            var accId = parseInt(labelId.text);
            if (destination != accId){
            listModelAuto.append({accId : "Account: " + destination, accAmount: amount, autoLastDate : lastPayment, intervalAuto : interval + " day(s)", transAutoId : id});
            }
        }
        onSendSettingsRefreshAccInfo: {
            listModelAuto.clear();
        }
        onSendSettingsRefreshAccHistory: {
            listModelHistory.clear();
        }
        onSendSettingsUpdateAccHistory: {
            listModelHistory.append({transId : id, transSecondAcc: "Account: "+connectedAcc, transAmount: amount, transDate : timeProcc});
        }
        onSendChangeSuccess: {
            labelLimit.text = "Your request will be processed soon"
            labelLimit.color = "#FF0000";
        }
        onSendChangeFailure: {
            labelLimit.text = "You can`t do this";
            labelLimit.color = "#FF0000";
        }
        onSendSetAccId: {
            labelId.text = id;
        }
    }

    function vipeInput(input){
        input.text = "";

    }

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
            id: paneAuto
            x: 1038
            y: 290
            width: 334
            height: 352
            rightPadding: 5
            leftPadding: 5
            bottomPadding: 40
            topPadding: 35
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 433
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
                    id: itemAuto

                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 50

                    // В данном элементе будет находиться одна кнопка
                    Button {
                        id: buttonL
                        height: 58
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        Label {
                            id: labelAutoId
                            y: 17
                            text: accId
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            font.pointSize: 14
                        }

                        Label {
                            id: labelAmount
                            x: 130
                            width: 93
                            height: 19
                            text: accAmount
                            horizontalAlignment: Text.AlignRight
                            font.pointSize: 11
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            anchors.right: parent.right
                            anchors.rightMargin: 47
                        }
                        Button {
                            id: buttonXX
                            x: 224
                            width: 46
                            text: qsTr("X")
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 24
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            highlighted: true

                            onClicked: {
                                console.log(labelIdAuto.text);

                                appCore.receiveDeleteAuto(labelIdAuto.text);
                                vipeInput(limitField);
                                labelLimit.text = "Change Credit Limit";
                                labelLimit.color = "#000000";
                            }
                        }

                        Label {
                            id: labelLastDate
                            x: 192
                            y: 35
                            width: 75
                            height: 17
                            text: autoLastDate
                            horizontalAlignment: Text.AlignRight
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 6
                            anchors.right: parent.right
                            anchors.rightMargin: 3
                        }

                        Label {
                            id: labelInterval
                            x: 122
                            y: 34
                            text: intervalAuto
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 7
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Label {
                            id: labelIdAuto
                            text: transAutoId
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                        }


                    }
                }

                // Сама модель, в которой будут содержаться все элементы
                model: ListModel {
                    id: listModelAuto // задаём ей id для обращения
                }
            }
        }

        Label {
            id: labelId
            x: 624
            y: 180
            width: 18
            height: 23
            text: ""
            font.pointSize: 14
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
            anchors.verticalCenterOffset: -255
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
            validator: RegExpValidator {
                regExp: /^[0-9]+$/
            }
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
            onClicked: {
                appCore.receiveChangeLimit(labelId.text,limitField.text);
                vipeInput(limitField);
            }
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
            onClicked:  {
                vipeInput(limitField);
                labelLimit.text = "Change Credit Limit";
                labelLimit.color = "#000000";
                swipeView.currentIndex = 3;
            }
        }

        Pane {
            id: paneHistory
            x: 487
            y: 214
            width: 306
            height: 352
            bottomPadding: 40
            topPadding: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            ListView {
                id: listView2
                // Размещаем его в оставшейся части окна приложения
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                /* в данном свойстве задаём вёрстку одного объекта
                     * который будем отображать в списке в качестве одного элемента списка
                     * */
                delegate: Item {
                    id: itemHistory

                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 50

                    // В данном элементе будет находиться одна кнопка
                    Button {
                        id: buttonLol
                        height: 58
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        Label {
                            id: labelLol
                            text: transId
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            font.pointSize: 11
                        }

                        Label {
                            id: label5
                            x: 203
                            y: 33
                            width: 79
                            height: 17
                            text: transDate
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            horizontalAlignment: Text.AlignRight
                        }

                        Label {
                            id: label7
                            y: 32
                            text: transSecondAcc
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 3
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            font.pointSize: 14
                        }

                        Label {
                            id: labelLok
                            x: 146
                            width: 136
                            height: 26
                            text: transAmount
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            horizontalAlignment: Text.AlignRight
                            font.pointSize: 14
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                        }




                    }
                }

                // Сама модель, в которой будут содержаться все элементы
                model: ListModel {
                    id: listModelHistory // задаём ей id для обращения
                }
            }
        }

    }
}
