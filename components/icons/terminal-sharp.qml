// Generated from SVG file terminal-sharp.svg
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
            PathSvg { path: "M 16 44 L 16 468 C 16 474.627 21.3726 480 28 480 L 484 480 C 490.627 480 496 474.627 496 468 L 496 44 C 496 37.3726 490.627 32 484 32 L 28 32 C 21.3726 32 16 37.3726 16 44 M 73.51 237.5 L 150.39 176 L 73.51 114.5 L 93.51 89.5 L 201.61 176 L 93.5 262.49 L 73.51 237.5 M 272 256 L 176 256 L 176 224 L 272 224 L 272 256 " }
        }
    }
}
