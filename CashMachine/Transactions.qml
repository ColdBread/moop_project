import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0


TransactionsForm {
    property alias textAmount: textAmount
    property alias submit: submit
    property alias textPeriod: textPeriod

    Connections {
        target: appCore

        onSendTransUpdateAccInfo: {
            //comboAccs.addItem(id.toString()+"         "+amount.toString() +" limit: "+limit.toString,id.toVariant());
            console.log(id.toString()+"         "+amount.toString() +" limit: "+limit.toString());
            //({ accAmount: amount, accLimit: limit});
            listModelTrans.append({key : id.toString()+"         "+amount.toString() +" limit: "+limit.toString(), idshnik : id})
        }
        onSendTransRefreshAccInfo: {
            listModelTrans.clear();
        }
        onSendFinishedTransfer: {
            appCore.receiveAccounts();
        }
        onSendEqualIDs: {
            label3.text = "You can`t transfer on equal accounts"
        }
        onSendNoEnoughMoney: {
            label3.text = "You don`t have enough money for transfer";
        }
    }

    function clearInputs() {
        switchRegular.checked = false;
        label3.text = "Transfer";
        vipeInput(textDestination);
        vipeInput(textPeriod);
        vipeInput(textAmount);
    }

    function vipeInput(input){
        input.text = "";

    }


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
            anchors.verticalCenterOffset: -96
            anchors.horizontalCenterOffset: -328
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            textRole: "key"
            model: ListModel {
                id: listModelTrans // задаём ей id для обращения
            }
        }

        Label {
            id: label
            x: 504
            width: 179
            height: 40
            text: qsTr("Choose Your Account")
            anchors.verticalCenterOffset: -173
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: -327
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
            anchors.verticalCenterOffset: -181
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 315
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 14
        }

        TextField {
            id: textDestination
            x: 504
            y: 370
            width: 272
            height: 40
            anchors.verticalCenterOffset: -92
            anchors.horizontalCenterOffset: 314
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            validator: RegExpValidator {
                regExp: /^[0-9]+$/
            }
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
            y: 542
            text: "<"
            highlighted: true
            anchors.left: parent.left
            anchors.leftMargin: 64
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 190
            onClicked: {
                console.log("Button Pressed Back");
                clearInputs();
                swipeView.currentIndex = 3;
            }
        }

        TextField {
            id: textPeriod
            x: 668
            y: 463
            width: 61
            height: 43
            horizontalAlignment: Text.AlignRight
            enabled: switchRegular.checked ? true: false;
            validator: RegExpValidator {
                regExp: /^[0-9]+$/
            }
        }

        Label {
            id: label2
            x: 734
            y: 472
            width: 42
            height: 28
            text: qsTr("Days")
            font.pointSize: 14
        }

        Label {
            id: label3
            x: 605
            y: 194
            text: qsTr("Transfer")
            font.pointSize: 14
            anchors.verticalCenterOffset: -184
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: textAmount
            x: 580
            y: 254

            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: -93
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            validator: RegExpValidator {
                regExp: /^[0-9]+\.?[0-9]{2}$/
            }
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
            onClicked: {
                console.log("Button Pressed Submit");
                switchRegular.checked ? appCore.receiveRegularTrans(listModelTrans.get(comboAccs.currentIndex).idshnik,textDestination.text,textAmount.text,textPeriod.text) : appCore.receiveTrans(listModelTrans.get(comboAccs.currentIndex).idshnik,textDestination.text,textAmount.text);
                clearInputs();
                /*console.log(comboAccs.currentIndex);
                console.log(listModelTrans.get(comboAccs.currentIndex).idshnik);
                console.log(textAmount.text);
                console.log(textDestination.text);*/
                //swipeView.currentIndex = 3;
            }
        }



    }
}
