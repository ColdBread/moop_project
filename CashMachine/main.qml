import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 1280
    height: 780
    title: qsTr("Hello World")
    property variant globalPhone: "";
    property variant globalToken: "";

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: swipeView.currentIndex
        interactive: false


        Page1 {
        }
        LoginPage {

        }
        Verification{

        }
        MainUserPage{

        }
        Transactions{

        }
        EditAccount{

        }
        AccountSettings{

        }


    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("E-Banking")
            enabled: false
        }

    }
}
