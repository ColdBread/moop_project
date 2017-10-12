import QtQuick 2.4

MainUserPageForm {
    quitButton.onClicked: {
        console.log("Button Pressed Quit");
        swipeView.currentIndex = 1
    }
}
