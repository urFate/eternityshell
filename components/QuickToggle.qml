import QtQuick
import eternityshell.theme

Rectangle {
    id: root

    property string iconName: ""
    property string title: ""
    property string subtitle: ""

    property bool active: false

    property color foregroundColor: Theme.shadeSurface
    property color inactiveForegroundColor: Theme.accent

    readonly property color currentForegroundColor:
        root.active
        ? root.foregroundColor
        : root.inactiveForegroundColor

    property color activeColor: Theme.accent
    property color inactiveColor: Theme.shadeSurface

    signal clicked()

    color: root.active
           ? root.activeColor
           : root.inactiveColor

    Behavior on color {
        ColorAnimation {
            duration: 140
        }
    }

    property real pressScale: mouseArea.pressed ? 0.94 : 1

    scale: pressScale

    Behavior on pressScale {
        NumberAnimation {
            duration: 110
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        anchors.fill: parent

        color: "#000000"

        opacity: mouseArea.pressed ? 0.12 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 80
            }
        }
    }

    Column {
        anchors {
            left: parent.left
            bottom: parent.bottom

            leftMargin: 14
            bottomMargin: 12
        }

        spacing: 4

        SvgIcon {
            name: root.iconName

            width: 24
            height: 24

            color: root.currentForegroundColor
        }

        Text {
            text: root.title

            color: root.currentForegroundColor

            font.pixelSize: 15
        }

        Text {
            text: root.subtitle

            color: Qt.lighter(root.currentForegroundColor, 0.87)

            font.pixelSize: 11
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: root.clicked()
    }
}
