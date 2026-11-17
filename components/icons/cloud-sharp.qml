// Generated from SVG file cloud-sharp.svg
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
            PathSvg { path: "M 396 432 L 136 432 C 99.56 432 65.64 419.43 40.49 396.59 C 14.38 372.88 0 340 0 304 C 0 267.42 13.39 235.88 38.72 212.78 C 58.65 194.59 85.84 182.22 116.1 177.41 C 125.557 152.726 141.114 130.842 161.32 113.8 C 187.76 91.69 220.5 80 256 80 C 295.933 79.8262 334.363 95.214 363.14 122.9 C 390.2 148.96 407.73 184.18 414.25 225.36 C 463.56 232.66 512 266.15 512 328 C 512 361.39 499.76 388.78 476.59 407.23 C 456.23 423.43 428.37 432 396 432 " }
        }
    }
}
