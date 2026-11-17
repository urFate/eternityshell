// Generated from SVG file chatbubble-sharp.svg
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
            PathSvg { path: "M 475.22 206.52 C 464.88 157.87 437.46 113.59 398 81.84 C 357.647 49.5531 307.5 31.9745 255.82 32 C 194.9 32 138 55.47 95.46 98.09 C 54.35 139.33 31.82 193.78 32 251.37 C 32.0014 293.593 44.3972 334.887 67.65 370.13 L 72 376.18 L 48 480 L 162.8 451.44 C 162.8 451.44 165.1 452.21 166.8 452.86 C 168.5 453.51 183.13 459.12 198.65 463.46 C 211.55 467.06 238.39 472.46 259.42 472.46 C 319.07 472.46 374.77 449.36 416.25 407.4 C 457.36 365.77 480 310.42 480 251.49 C 480.003 236.373 478.401 221.299 475.22 206.52 " }
        }
    }
}
