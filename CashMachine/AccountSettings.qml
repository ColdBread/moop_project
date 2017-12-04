import QtQuick 2.4

AccountSettingsForm {

    Connections {
        target: appCore

        /*onSendEditUpdateAccInfo: {
            listModel.append({accId: id, accAmount: amount, accLimit: limit});
        }
        onSendEditRefreshAccInfo: {
            listModel.clear();
        }*/
    }


    roundBackButton.onClicked:  {
                                   swipeView.currentIndex = 3;
                               }

    sendLimitButton.onClicked: {
        appCore.receiveChangeLimit(limitField.text);
        vipeInput(limitField);
    }

    function vipeInput(input){
        input.text = "";

    }
}
