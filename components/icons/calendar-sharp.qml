// Generated from SVG file calendar-sharp.svg
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
            PathSvg { path: "M 32 456 C 32 469.255 42.7452 480 56 480 L 456 480 C 469.255 480 480 469.255 480 456 L 480 176 L 32 176 L 32 456 M 352 212 C 352 209.791 353.791 208 356 208 L 396 208 C 398.209 208 400 209.791 400 212 L 400 252 C 400 254.209 398.209 256 396 256 L 356 256 C 353.791 256 352 254.209 352 252 L 352 212 M 352 292 C 352 289.791 353.791 288 356 288 L 396 288 C 398.209 288 400 289.791 400 292 L 400 332 C 400 334.209 398.209 336 396 336 L 356 336 C 353.791 336 352 334.209 352 332 L 352 292 M 272 212 C 272 209.791 273.791 208 276 208 L 316 208 C 318.209 208 320 209.791 320 212 L 320 252 C 320 254.209 318.209 256 316 256 L 276 256 C 273.791 256 272 254.209 272 252 L 272 212 M 272 292 C 272 289.791 273.791 288 276 288 L 316 288 C 318.209 288 320 289.791 320 292 L 320 332 C 320 334.209 318.209 336 316 336 L 276 336 C 273.791 336 272 334.209 272 332 L 272 292 M 272 372 C 272 369.791 273.791 368 276 368 L 316 368 C 318.209 368 320 369.791 320 372 L 320 412 C 320 414.209 318.209 416 316 416 L 276 416 C 273.791 416 272 414.209 272 412 L 272 372 M 192 292 C 192 289.791 193.791 288 196 288 L 236 288 C 238.209 288 240 289.791 240 292 L 240 332 C 240 334.209 238.209 336 236 336 L 196 336 C 193.791 336 192 334.209 192 332 L 192 292 M 192 372 C 192 369.791 193.791 368 196 368 L 236 368 C 238.209 368 240 369.791 240 372 L 240 412 C 240 414.209 238.209 416 236 416 L 196 416 C 193.791 416 192 414.209 192 412 L 192 372 M 112 292 C 112 289.791 113.791 288 116 288 L 156 288 C 158.209 288 160 289.791 160 292 L 160 332 C 160 334.209 158.209 336 156 336 L 116 336 C 113.791 336 112 334.209 112 332 L 112 292 M 112 372 C 112 369.791 113.791 368 116 368 L 156 368 C 158.209 368 160 369.791 160 372 L 160 412 C 160 414.209 158.209 416 156 416 L 116 416 C 113.791 416 112 414.209 112 412 L 112 372 " }
        }
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 456 64 L 400.08 64 L 400.08 32 L 352.08 32 L 352.08 64 L 159.92 64 L 159.92 32 L 111.92 32 L 111.92 64 L 56 64 C 49.6585 63.9467 43.5579 66.4265 39.0521 70.8892 C 34.5462 75.3518 32.0078 81.4282 32 87.77 L 32 144 L 480 144 L 480 87.77 C 479.992 81.4282 477.454 75.3518 472.948 70.8892 C 468.442 66.4265 462.342 63.9467 456 64 " }
        }
    }
}
