// Generated from SVG file settings-sharp.svg
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
            PathSvg { path: "M 256 176 C 211.817 176 176 211.817 176 256 C 176 300.183 211.817 336 256 336 C 300.183 336 336 300.183 336 256 C 335.868 211.872 300.128 176.132 256 176 M 428.72 256 C 428.678 263.475 428.13 270.939 427.08 278.34 L 475.77 316.46 C 480.15 320.077 481.264 326.334 478.4 331.24 L 432.34 410.76 C 429.45 415.619 423.485 417.699 418.2 415.69 L 360.95 392.69 C 349.029 401.87 335.983 409.488 322.13 415.36 L 313.57 476.14 C 312.582 481.755 307.76 485.886 302.06 486 L 209.94 486 C 204.352 485.891 199.579 481.939 198.43 476.47 L 189.87 415.69 C 175.979 409.886 162.924 402.256 151.05 393 L 93.8 416 C 88.5173 418.011 82.5535 415.936 79.66 411.08 L 33.6 331.57 C 30.7365 326.664 31.85 320.407 36.23 316.79 L 84.92 278.67 C 83.8815 271.157 83.3336 263.584 83.28 256 C 83.3216 248.525 83.8695 241.061 84.92 233.66 L 36.23 195.54 C 31.85 191.923 30.7365 185.666 33.6 180.76 L 79.66 101.24 C 82.5504 96.3805 88.5149 94.301 93.8 96.31 L 151.05 119.31 C 162.971 110.13 176.017 102.512 189.87 96.64 L 198.43 35.86 C 199.418 30.2454 204.24 26.1144 209.94 26 L 302.06 26 C 307.648 26.1088 312.421 30.0606 313.57 35.53 L 322.13 96.31 C 336.039 102.11 349.111 109.74 361 119 L 418.2 96 C 423.483 93.9892 429.446 96.0643 432.34 100.92 L 478.4 180.44 C 481.264 185.346 480.15 191.603 475.77 195.22 L 427.08 233.34 C 428.118 240.85 428.666 248.419 428.72 256 " }
        }
    }
}
