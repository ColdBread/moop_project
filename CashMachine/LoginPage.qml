import QtQuick 2.4

LoginPageForm {

    Connections {
            target: appCore // Указываем целевое соединение
            /* Объявляем и реализуем функцию, как параметр
             * объекта и с имененем похожим на название сигнала
             * Разница в том, что добавляем в начале on и далее пишем
             * с заглавной буквы
             * */
            onSendLogin: {
                vipeInput(phoneField)
                vipeInput(passwordField)
                swipeView.currentIndex = 2
            }
            onSendTooManyReqLogin: {

            }

        }


    loginButton.onClicked: {
        console.log("Button Pressed Login");
        if(checkInputs (phoneField.text, passwordField.text)) {

            appCore.receiveLogin(phoneField.text, passwordField.text)


        }



    }

        function checkInputs (phone, password) {
            var checkRes = true;
            if(!checkPhone(phone)) {

                changePhoneLabel();
                checkRes = false;
            }

            if(!checkPassword(password)) {

                changePasswordLabel();
                checkRes = false;
            }
            return checkRes;
        }


            function checkPhone(phone) {
                var phoneRegExp = /^\+[0-9]{12}$/;
                return (phone.length > 6 && phoneRegExp.test(phone));
            }

            function checkPassword(password) {
                var pswrdRegExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{2,}$/;
                return (password.length > 1 && pswrdRegExp.test(password));
            }

            function changePhoneLabel() {
                phoneNumberLabel.text = "Phone Number (your input is invalid)";
                phoneNumberLabel.color = "#FF0000";
            }

            function changePasswordLabel() {
                passwordLabel.text = "Password (At least 1 letter and 1 number)";
                passwordLabel.color = "#FF0000";
            }

        /*function makeRequest(phone,password) {
            var request = new XMLHttpRequest();
            var url = '/auth/send-sms?phone='+phone+'&password='+password;
            request.open('GET',url);
            request.onreadystatechange = function () {
                if (request.readyState === XMLHttpRequest.DONE) {
                    if (request.status === 200) {
                        console.log(request.responseText)
                        globalPhone = phone;
                        vipeInput(phoneField);
                        vipeInput(passwordField);
                        swipeView.currentIndex = 2;
                    } else if (request.status === 429) {
                        console.log("Too many requests",request.status);
                        //make label too many tries
                    } else if (request.status === 400) {
                        console.log("Bad Request",request.status);
                        //
                    }else {
                        console.log("HTTP request failed", request.status)
                    }
                }
            }
            request.send();
        }*/
        function vipeInput(input){
            input.text = "";

        }

}
