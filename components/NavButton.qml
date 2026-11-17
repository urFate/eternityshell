import QtQuick
import eternityshell.theme

Item {
    id: root

    property string iconName: ""
    property bool active: false
    property bool buttonEnabled: true

    signal tapped()

    implicitWidth: 48
    implicitHeight: Theme.navBarHeight

    width: implicitWidth
    height: implicitHeight

    property real pressScale:
        mouse.pressed && root.buttonEnabled ? 0.88 : 1

    scale: pressScale

    Behavior on pressScale {
        NumberAnimation {
            duration: 90
            easing.type: Easing.OutCubic
        }
    }

    SvgIcon {
        anchors.centerIn: parent

        name: root.iconName

        width: 22
        height: 22

        dimmed: !root.buttonEnabled
    }

    MouseArea {
        id: mouse

        anchors.fill: parent

        enabled: root.buttonEnabled

        onClicked: root.tapped()
    }
}
