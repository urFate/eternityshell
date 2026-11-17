// Generated from SVG file images-sharp.svg
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
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 80 132 L 80 460 C 80 471.046 88.9543 480 100 480 L 492 480 C 503.046 480 512 471.046 512 460 L 512 132 C 512 120.954 503.046 112 492 112 L 100 112 C 88.9543 112 80 120.954 80 132 M 373.14 173.33 C 398.508 173.484 418.962 194.147 418.86 219.516 C 418.757 244.884 398.136 265.38 372.767 265.329 C 347.399 265.278 326.86 244.699 326.86 219.33 C 326.965 193.859 347.669 173.28 373.14 173.33 M 111.73 449.33 L 111.73 353.85 L 234.49 243.65 L 328.27 337 L 215.27 449.33 L 111.73 449.33 M 480 449.33 L 259 449.33 L 403.58 305.33 L 480 370.59 L 480 449.33 " }
        }
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 20 32 C 8.95431 32 1.35266e-15 40.9543 0 52 L 0 396 C 1.35266e-15 407.046 8.95431 416 20 416 L 48 416 L 48 100 C 48 88.9543 56.9543 80 68 80 L 448 80 L 448 52 C 448 40.9543 439.046 32 428 32 L 20 32 " }
        }
    }
}
