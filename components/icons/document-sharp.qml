// Generated from SVG file document-sharp.svg
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
            PathSvg { path: "M 240 216 L 240 32 L 92 32 C 85.3726 32 80 37.3726 80 44 L 80 468 C 80 474.627 85.3726 480 92 480 L 420 480 C 426.627 480 432 474.627 432 468 L 432 224 L 248 224 C 243.582 224 240 220.418 240 216 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 272 41.69 L 272 188 C 272 190.209 273.791 192 276 192 L 422.31 192 C 423.118 192.001 423.847 191.515 424.158 190.769 C 424.469 190.023 424.3 189.163 423.73 188.59 L 275.41 40.27 C 274.837 39.7003 273.977 39.5314 273.231 39.8421 C 272.485 40.1528 271.999 40.8819 272 41.69 " }
        }
    }
}
