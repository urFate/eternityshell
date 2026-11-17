// Generated from SVG file arrow-back-sharp.svg
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
            strokeWidth: 48
            capStyle: ShapePath.SquareCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 244 400 L 100 256 L 244 112 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: color
            strokeWidth: 48
            capStyle: ShapePath.SquareCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 120 256 L 412 256 " }
        }
    }
}
