// Generated from SVG file volume-high-sharp.svg
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
            strokeColor: color
            strokeWidth: 32
            capStyle: ShapePath.SquareCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 320 320 C 329.74 300.62 336 279.16 336 256 C 336 232.52 330 211.58 320 192 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: color
            strokeWidth: 32
            capStyle: ShapePath.SquareCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 368 368 C 387.48 334.08 400 303.94 400 256 C 400 208.06 388 178.26 368 144 " }
        }
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: color
            strokeWidth: 32
            capStyle: ShapePath.SquareCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 416 416 C 446 370 464 324.57 464 256 C 464 187.43 446 143 416 96 " }
        }
        ShapePath {
            id: _qt_node4_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 125.65 176.1 L 32 176.1 L 32 335.9 L 125.65 335.9 L 256 440 L 256 72 L 125.65 176.1 " }
        }
    }
}
