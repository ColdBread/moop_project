import QtQuick 2.4

MainUserPageForm {
    quitButton.onClicked: {
        console.log("Button Pressed Quit");

        swipeView.currentIndex = 1
    }

    button1.onClicked: {
        console.log("Button Pressed Transactions");
        swipeView.currentIndex = 4;
    }

}
