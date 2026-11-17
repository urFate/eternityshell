import QtQuick
import QtQuick.Effects
import eternityshell.theme

Item {
    id: root
    property bool backEnabled: false
    property bool homeActive: true
    property bool backgroundActive: false
    property real backgroundOpacity: 0.55   // glass is translucent, not opaque
    signal navigateBackground()
    signal navigateHome()
    signal navigateBack()

    implicitHeight: Theme.navBarHeight
    height: implicitHeight

    // 1. The item that gets captured & blurred (this should be
    //    whatever sits BEHIND the navbar - a screenshot of content,
    //    a wallpaper Image, etc. Using itself as placeholder here.)
    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        color: Theme.navBarBackground
        visible: backgroundOpacity == 1
    }

    // 2. Blurred + tinted "frosted" layer
    MultiEffect {
        id: glassEffect
        anchors.fill: backgroundItem
        source: backgroundItem

        blurEnabled: true
        blur: 1.0
        blurMax: 64          // glass usually wants a heavier blur than 32
        blurMultiplier: 1.5

        saturation: 0.15     // slight boost - glass often looks a bit more vivid
        opacity: root.backgroundOpacity
    }

    // 3. Tint overlay - this is what actually gives the "glass color"
    //    (frosted white glass, or a brand-colored tint)
    Rectangle {
        anchors.fill: backgroundItem
        color: Theme.navBarBackground
        opacity: 0.25
    }

    // 4. Border highlight - thin light stroke that catches "light"
    //    like real glass edges do. Very important for the illusion.
    Rectangle {
        anchors.fill: backgroundItem
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.18)
        radius: backgroundItem.radius ?? 0
    }

    // 5. Optional: subtle top highlight gradient (like light hitting glass)
    Rectangle {
        anchors.top: backgroundItem.top
        anchors.left: backgroundItem.left
        anchors.right: backgroundItem.right
        height: parent.height * 0.4
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.12) }
            GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.0) }
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 58
        NavButton {
            iconName: "apps-sharp"
            active: root.backgroundActive
            onTapped: root.navigateBackground()
        }
        NavButton {
            iconName: "home-sharp"
            active: root.homeActive
            onTapped: root.navigateHome()
        }
        NavButton {
            iconName: "arrow-back-sharp"
            buttonEnabled: root.backEnabled
            opacity: buttonEnabled ? 1 : 0.35
            onTapped: root.navigateBack()
        }
    }
}
