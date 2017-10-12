import QtQuick 2.4

VerificationForm {
    verificationButton.onClicked: {
        console.log("Button Pressed verify");
        swipeView.currentIndex = 3
    }
}
