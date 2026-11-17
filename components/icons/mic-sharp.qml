// Generated from SVG file mic-sharp.svg
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
            PathSvg { path: "M 192 448 L 320 448 " }
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
            PathSvg { path: "M 384 208 L 384 240 C 384 310.4 326.4 368 256 368 C 185.6 368 128 310.4 128 240 L 128 208 " }
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
            PathSvg { path: "M 256 368 L 256 448 " }
        }
        ShapePath {
            id: _qt_node4_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 256 320 C 234.665 319.95 214.262 311.255 199.45 295.9 C 184.442 280.764 176.014 260.316 176 239 L 176 128 C 175.917 106.757 184.319 86.361 199.34 71.3401 C 214.361 56.3192 234.757 47.9172 256 48 C 300.86 48 336 83.14 336 128 L 336 239 C 336 283.66 300.11 320 256 320 " }
        }
    }
}
