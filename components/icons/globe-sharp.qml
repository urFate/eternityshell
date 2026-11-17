// Generated from SVG file globe-sharp.svg
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
            strokeWidth: 44
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 256 48 C 141.13 48 48 141.13 48 256 C 48 370.87 141.13 464 256 464 C 370.87 464 464 370.87 464 256 C 464 141.13 370.87 48 256 48 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: color
            strokeWidth: 44
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 256 48 C 197.93 48 143.33 141.13 143.33 256 C 143.33 370.87 197.93 464 256 464 C 314.07 464 368.67 370.87 368.67 256 C 368.67 141.13 314.07 48 256 48 " }
        }
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: color
            strokeWidth: 44
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 117.33 121.33 C 155.57 148.48 203.71 164.67 256 164.67 C 308.29 164.67 356.43 148.48 394.67 121.33 " }
        }
        ShapePath {
            id: _qt_node4_fill_stroke
            strokeColor: color
            strokeWidth: 44
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            miterLimit: 4
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 394.67 390.67 C 356.43 363.52 308.29 347.33 256 347.33 C 203.71 347.33 155.57 363.52 117.33 390.67 " }
        }
        ShapePath {
            id: _qt_node5_fill_stroke
            strokeColor: color
            strokeWidth: 44
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 256 48 L 256 464 " }
        }
        ShapePath {
            id: _qt_node6_fill_stroke
            strokeColor: color
            strokeWidth: 44
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            miterLimit: 10
            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 464 256 L 48 256 " }
        }
    }
}
