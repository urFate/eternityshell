import QtQuick
import eternityshell.theme

Item {
    id: root

    property string name: ""
    property bool dimmed: false
    property color color: Theme.iconColor

    implicitWidth: 20
    implicitHeight: 20

    width: implicitWidth
    height: implicitHeight

    opacity: dimmed ? 0.35 : 1

    Behavior on opacity {
        NumberAnimation {
            duration: 120
        }
    }

    Loader {
        id: loader

        anchors.fill: parent
        active: root.name.length > 0

        source: root.name.length > 0
                ? "./icons/" + root.name + ".qml"
                : ""

        onLoaded: {
            if (item) {
                item.color = root.color
                item.anchors.fill = loader
            }
        }

        Connections {
            target: root

            function onColorChanged() {
                if (loader.item) {
                    loader.item.color = root.color
                }
            }
        }
    }
}
