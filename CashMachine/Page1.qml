import QtQuick 2.7

Page1Form {
    getStarted.onClicked: {
        console.log("Button Pressed getStarted");
        swipeView.currentIndex = 1
    }
}
