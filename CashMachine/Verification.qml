import QtQuick 2.4

VerificationForm {
    Connections {
        target: appCore

        onSendVerification: {

            vipeInput(verificationPassword);
            swipeView.currentIndex = 3;
        }



        onSendVerificationBad: {
            vipeInput(verificationPassword);
            swipeView.currentIndex = 2;
        }
    }

    verificationButton.onClicked: {
        console.log("Button Pressed verify");
        if(checkInput(verificationPassword.text)) {
            //makeRequest(Phone, verificationPassword.text);
            appCore.receiveVerification(verificationPassword.text)
        }
    }

    function checkInput(code) {
        var codeRegExp = /[A-Za-z0-9]{5}/;
        return (code.length > 3 && codeRegExp.test(code));
    }
    function vipeInput(input){
        input.text = "";

    }
}
