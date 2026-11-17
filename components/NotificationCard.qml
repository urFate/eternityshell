import QtQuick
import eternityshell.theme

Rectangle {
    id: root

    property string iconName: ""
    property string title: ""
    property string subtitle: ""
    property color accentColor: Theme.accent

    height: 78

    color: Theme.shadeSurface

    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        width: 4

        color: root.accentColor
    }

    Row {
        anchors.fill: parent
        anchors.margins: 14

        spacing: 14

        SvgIcon {
            name: root.iconName

            width: 24
            height: 24

            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            spacing: 2

            Text {
                text: root.title

                color: Theme.text

                font.pixelSize: 16
            }

            Text {
                text: root.subtitle

                color: Theme.secondaryText

                font.pixelSize: 13
            }
        }
    }
}
