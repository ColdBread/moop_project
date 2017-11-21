import QtQuick 2.4

TransactionsForm {
    roundButtonBack.onClicked: {
        console.log("Button Pressed Back");

        swipeView.currentIndex = 3;
    }
    submit.onClicked: {
        console.log("Button Pressed Submit");
        swipeView.currentIndex = 3;
    }
}
