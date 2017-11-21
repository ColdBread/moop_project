import QtQuick 2.4

MainUserPageForm {
    Connections {
        target: appCore

    }
    Component.onCompleted: {
        appCore.receiveAccounts();
    }

    quitButton.onClicked: {
        console.log("Button Pressed Quit");

        swipeView.currentIndex = 1
    }

    button1.onClicked: {
        console.log("Button Pressed Transactions");
        swipeView.currentIndex = 4;
    }

}
