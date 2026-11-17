import QtQuick
import eternityshell.theme

Item {
    id: root

    property real value: 0.75

    implicitHeight: 26

    height: implicitHeight

    Rectangle {
        id: track

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        height: 4

        color: Theme.surfaceLight

        Rectangle {
            width: parent.width * root.value

            height: parent.height

            color: Theme.accentBright
        }
    }

    Rectangle {
        id: handle

        width: 14
        height: 14

        radius: 7

        color: Theme.text

        x: (root.width - width) * root.value
        anchors.verticalCenter: parent.verticalCenter

        Behavior on x {
            enabled: !dragArea.pressed

            NumberAnimation {
                duration: 80
            }
        }
    }

    MouseArea {
        id: dragArea

        anchors.fill: parent

        onPressed: (mouse) => {
            updateValue(mouse.x)
        }

        onPositionChanged: (mouse) => {
            if (pressed)
                updateValue(mouse.x)
        }
    }

    function updateValue(posX) {
        var v = Math.max(0, Math.min(1, posX / root.width))

        if (v !== root.value)
            root.value = v
    }
}
