import QtQuick 2.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Item {
    id: item1
    width: 1280
    height: 780
    property alias verificationButton: verificationButton
    property alias verificationPassword: verificationPassword

    Background {
        id: background
        anchors.fill: parent
    }

    ColumnLayout {
        x: 455
        width: 370
        height: 385
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 91

        Label {
            id: label
            text: qsTr("On your phone number has been sent a code. Please enter it here to verify your account.")
            Layout.preferredHeight: 88
            Layout.preferredWidth: 370
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            textFormat: Text.AutoText
            font.underline: false
        }

        TextField {
            id: verificationPassword
            echoMode: TextInput.Password
            text: qsTr("")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 43
            Layout.preferredWidth: 179
            font.pointSize: 18
        }

        Button {
            id: verificationButton
            text: qsTr("Verify")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            checked: true
            highlighted: true
            font.pointSize: 18
        }
    }
}
