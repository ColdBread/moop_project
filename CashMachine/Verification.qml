import QtQuick 2.4

VerificationForm {
    verificationButton.onClicked: {
        console.log("Button Pressed verify");
        if(checkInput(verificationPassword.text)) {
            //makeRequest(Phone, verificationPassword.text);
            swipeView.currentIndex = 3;
        }


    }

    function checkInput(code) {
        var codeRegExp = /[0-9]{4}/;
        return (code.length > 3 && codeRegExp.test(code));
    }

    function makeRequest(phone, code) {
        var request = new XMLHttpRequest();
        var url = '/auth/verify-sms?phone='+phone+'&code='+code;
        request.open('GET',url);
        request.onreadystatechange = function () {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    console.log(request.responseText);
                    var result = JSON.parse(request.responseText);
                    globalToken = result.token;
                    vipeInput(verificationPassword);
                    swipeView.currentIndex = 3;
                } else if (request.status === 401) {
                    console.log("Unauthorized",request.status);
                    //bad code make resend after a few minutes
                }else {
                    console.log("HTTP request failed", request.status)
                }
            }
        }
        request.send();
    }
    function vipeInput(input){
        input.text = "";

    }
}
