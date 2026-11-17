// Generated from SVG file musical-notes-sharp.svg
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
            PathSvg { path: "M 429.46 32.07 C 405.86 38.6 223.91 90.88 178.92 103.5 C 177.201 103.982 176.01 105.545 176 107.33 L 176 354.33 C 176.002 355.178 175.469 355.936 174.67 356.22 L 146.82 365.77 C 127.82 373.21 80 382.45 80 424.96 C 80 460.5 104.63 476.5 125.86 479.24 C 128.439 479.703 131.05 479.97 133.67 480.04 C 141.04 480.04 170.05 472.96 186.97 461.96 C 208 448.25 208 448 208 412 L 208 202 C 208 201.1 208.62 201.16 209.48 200.93 L 397.48 149.01 C 398.094 148.841 398.752 148.974 399.252 149.369 C 399.751 149.764 400.033 150.373 400.01 151.01 L 400.01 306.55 C 400.008 307.406 399.461 308.166 398.65 308.44 C 389.75 311.44 379.42 314.94 372.17 317.56 C 341.39 328.68 304 335.65 304 376 C 304 414.51 332.26 430.58 350.3 431.83 C 357.424 432.37 364.588 432.034 371.63 430.83 C 380.63 429.45 395.72 424.93 409.77 415.97 C 432 401.79 432 401.51 432 360 L 432 34 C 432.001 33.3734 431.709 32.7824 431.21 32.4033 C 430.711 32.0242 430.063 31.9008 429.46 32.07 " }
        }
    }
}
