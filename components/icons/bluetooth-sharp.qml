// Generated from SVG file bluetooth-sharp.svg
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
            PathSvg { path: "M 397.41 161.13 L 236 -0.28 L 236 212.52 L 141.83 131.8 L 115.83 162.17 L 225.27 256 L 115.8 349.83 L 141.8 380.2 L 236 299.48 L 236 512.28 L 397.41 350.87 L 286.73 256 L 397.41 161.13 M 276 96.28 L 338.59 158.87 L 276 212.52 L 276 96.28 M 338.58 353.13 L 276 415.72 L 276 299.48 L 338.58 353.13 " }
        }
    }
}
