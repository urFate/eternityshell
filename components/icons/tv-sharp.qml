// Generated from SVG file tv-sharp.svg
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
            PathSvg { path: "M 488 384 L 24 384 C 19.5817 384 16 380.418 16 376 L 16 88 C 16 83.5817 19.5817 80 24 80 L 488 80 C 492.418 80 496 83.5817 496 88 L 496 376 C 496 380.418 492.418 384 488 384 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 116 400 L 396 400 C 398.209 400 400 401.791 400 404 L 400 428 C 400 430.209 398.209 432 396 432 L 116 432 C 113.791 432 112 430.209 112 428 L 112 404 C 112 401.791 113.791 400 116 400 " }
        }
    }
}
