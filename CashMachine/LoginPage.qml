import QtQuick 2.4

LoginPageForm {
    loginButton.onClicked: {
        console.log("Button Pressed Login");
        swipeView.currentIndex = 2
    }
}
