pragma Singleton

import QtQuick

QtObject {
    readonly property color background: "#f2f2f2"

    readonly property color surface: "#ffffff"
    readonly property color surfaceLight: "#e8e8e8"
    readonly property color surfacePressed: "#d4d4d4"

    readonly property color accent: "#0078d7"
    readonly property color accentBright: "#106ebe"
    readonly property color accentPressed: "#005a9e"

    readonly property color text: "#1a1a1a"
    readonly property color secondaryText: "#5c5c5c"
    readonly property color mutedText: "#8a8a8a"

    readonly property color iconColor: "#2d2d2d"

    readonly property color divider: "#d0d0d0"

    readonly property color shadeBackground: "#f5f5f7"
    readonly property color shadeBackgroundTop: "#ffffff"
    readonly property color shadeSurface: "#ffffff"
    readonly property color shadeSurfaceHover: "#ececec"

    readonly property color navBarBackground: "#e6e6e6"

    readonly property int navBarHeight: 64
    readonly property int shellMargin: 8

    readonly property int pageMargin: 24
    readonly property int tileGap: 8

    readonly property int touchTarget: 48
}
