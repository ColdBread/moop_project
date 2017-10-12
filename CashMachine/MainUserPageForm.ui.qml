import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

Item {
    width: 1280
    height: 780
    property alias quitButton: quitButton

    Background {
        id: background
        anchors.fill: parent

        ColumnLayout {
            x: 462
            y: 224
            width: 357
            height: 333

            Label {
                id: label
                text: qsTr("Welcome To Your Account")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 18
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Button {
                id: quitButton
                text: qsTr("Quit")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                autoExclusive: false
                highlighted: true
            }
        }
    }
}
