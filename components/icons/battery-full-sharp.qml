// Generated from SVG file battery-full-sharp.svg
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
            PathSvg { path: "M 17 384 L 449 384 L 449 128 L 17 128 L 17 384 M 49 160 L 417 160 L 417 352 L 49 352 L 49 160 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 70.69 182.94 L 395.32 182.94 L 395.32 329.07 L 70.69 329.07 L 70.69 182.94 " }
        }
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 465 202.67 L 497 202.67 L 497 309.34 L 465 309.34 L 465 202.67 " }
        }
    }
}
