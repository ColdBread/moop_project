import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: item1
    width: 1280
    height: 780
    property alias columnLayout: columnLayout
    property alias getStarted: getStarted
    z: 0
    property alias item1: item1

    ColumnLayout {
        id: columnLayout
        x: 590
        y: 340
        width: 566
        height: 500
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        z: 1

        Button {
            id: getStarted
            text: qsTr("Get Started")
            highlighted: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBaseline
            z: 2
        }
    }

    Rectangle {
        id: rectangle
        color: "#009688"
        anchors.fill: parent
    }
}
