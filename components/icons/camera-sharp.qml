// Generated from SVG file camera-sharp.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes
import QtQuick.Effects

Item {
    implicitWidth: 512
    implicitHeight: 512
    component AnimationsInfo : QtObject
    {
        property bool paused: false
        property int loops: 1
        signal restart()
    }
    property AnimationsInfo animations : AnimationsInfo {}
    transform: [
        Scale { xScale: width / 512; yScale: height / 512 }
    ]
    id: __qt_toplevel
    property color color: "#000000"
    Shape {
        preferredRendererType: Shape.CurveRenderer
        id: _qt_node0
        transformOrigin: Item.TopLeft
        ShapePath {
            id: _qt_node1_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 320 272 C 320 307.346 291.346 336 256 336 C 220.654 336 192 307.346 192 272 C 192 236.654 220.654 208 256 208 C 291.346 208 320 236.654 320 272 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 456 144 L 373 144 C 370 144 366.28 142.06 363.38 139 L 336.1 96.2 C 325 80 320 80 302 80 L 210 80 C 192 80 186 80 175.93 96.21 L 148.62 139 C 146.4 141.42 143.28 144 140 144 L 140 128 C 140 123.582 136.418 120 132 120 L 92 120 C 87.5817 120 84 123.582 84 128 L 84 144 L 56 144 C 42.7452 144 32 154.745 32 168 L 32 408 C 32 421.255 42.7452 432 56 432 L 456 432 C 469.255 432 480 421.255 480 408 L 480 168 C 480 154.745 469.255 144 456 144 M 260.51 367.9 C 220.904 369.76 184.229 347.08 168.2 310.814 C 152.171 274.549 160.087 232.16 188.123 204.123 C 216.16 176.087 258.549 168.171 294.814 184.2 C 331.08 200.229 353.76 236.904 351.9 276.51 C 349.525 325.966 309.966 365.525 260.51 367.9 " }
        }
    }
}
