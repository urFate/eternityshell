// Generated from SVG file sound.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes
import QtQuick.Effects

Item {
    implicitWidth: 24
    implicitHeight: 24
    component AnimationsInfo : QtObject
    {
        property bool paused: false
        property int loops: 1
        signal restart()
    }
    property AnimationsInfo animations : AnimationsInfo {}
    transform: [
        Scale { xScale: width / 24; yScale: height / 24 }
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
            PathSvg { path: "M 4 9 L 4 15 L 8 15 L 13 19 L 13 5 L 8 9 L 4 9 M 15.5 12 C 15.8431 11.0294 15.8431 9.97056 15.5 9 C 15.4071 8.56296 15.6154 8.11731 16.0102 7.90825 C 16.4051 7.69919 16.8908 7.77746 17.2 8.1 C 17.8124 9.6414 17.8124 11.3586 17.2 12.9 C 16.8908 13.2225 16.4051 13.3008 16.0102 13.0918 C 15.6154 12.8827 15.4071 12.437 15.5 12 " }
        }
    }
}
