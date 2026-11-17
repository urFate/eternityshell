// Generated from SVG file cellular-sharp.svg
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
            PathSvg { path: "M 496 432 L 400 432 L 400 80 L 496 80 L 496 432 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 368 432 L 272 432 L 272 160 L 368 160 L 368 432 " }
        }
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 240 432 L 144 432 L 144 224 L 240 224 L 240 432 " }
        }
        ShapePath {
            id: _qt_node4_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 112 432 L 16 432 L 16 288 L 112 288 L 112 432 " }
        }
    }
}
