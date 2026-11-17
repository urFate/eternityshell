// Generated from SVG file mail-sharp.svg
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
            PathSvg { path: "M 464 80 L 48 80 C 39.1634 80 32 87.1634 32 96 L 32 416 C 32 424.837 39.1634 432 48 432 L 464 432 C 472.837 432 480 424.837 480 416 L 480 96 C 480 87.1634 472.837 80 464 80 M 265.82 284.63 C 260.043 289.121 251.957 289.121 246.18 284.63 L 89.55 162.81 L 109.19 137.55 L 256 251.73 L 402.81 137.55 L 422.45 162.81 L 265.82 284.63 " }
        }
    }
}
