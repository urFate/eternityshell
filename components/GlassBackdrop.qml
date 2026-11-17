import QtQuick
import QtQuick.Effects

Item {
    id: root

    property Item sourceItem
    property rect sourceRect: Qt.rect(0, 0, 0, 0)
    property real wallpaperDim: 0.12
    property real blurAmount: 0.25
    property real blurProgress: 1
    property color tintColor: "#f2f2f2"
    property real tintOpacity: 0.48

    clip: true

    ShaderEffectSource {
        id: backdropCapture

        anchors.fill: parent
        sourceItem: root.sourceItem
        sourceRect: root.sourceRect
        textureSize: Qt.size(Math.max(1, root.width), Math.max(1, root.height))
        live: true
        hideSource: false
        visible: !!root.sourceItem && root.blurProgress > 0
    }

    MultiEffect {
        anchors.fill: parent
        source: backdropCapture
        blurEnabled: root.blurAmount > 0 && root.blurProgress > 0
        blur: root.blurAmount * root.blurProgress
        blurMax: 64
        blurMultiplier: 1.0
        autoPaddingEnabled: false
        opacity: root.blurProgress * (1 - root.wallpaperDim)
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(root.tintColor.r, root.tintColor.g,
                       root.tintColor.b, root.tintOpacity * root.blurProgress)
    }
}
