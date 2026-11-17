// Generated from SVG file search-sharp.svg
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
            PathSvg { path: "M 464 428 L 339.92 303.9 C 359.916 276.421 370.673 243.304 370.64 209.32 C 370.64 120.37 298.27 48 209.32 48 C 120.37 48 48 120.37 48 209.32 C 48 298.27 120.37 370.64 209.32 370.64 C 243.304 370.673 276.421 359.916 303.9 339.92 L 428 464 L 464 428 M 209.32 319.69 C 148.356 319.696 98.9318 270.277 98.93 209.313 C 98.9282 148.35 148.35 98.9282 209.313 98.93 C 270.277 98.9318 319.696 148.356 319.69 209.32 C 319.618 270.246 270.246 319.618 209.32 319.69 " }
        }
    }
}
