// Generated from SVG file sunny-sharp.svg
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
    id: _qt_node0
    property color color: "#000000"
    transformOrigin: Item.TopLeft
    Shape {
        id: _qt_node1
        transformOrigin: Item.TopLeft
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node1_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 234 26 L 278 26 L 278 118 L 234 118 L 234 26 " }
        }
    }
    Shape {
        id: _qt_node2
        transformOrigin: Item.TopLeft
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node2_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 234 394 L 278 394 L 278 486 L 234 486 L 234 394 " }
        }
    }
    Shape {
        id: _qt_node3
        transformOrigin: Item.TopLeft
        transform: TransformGroup {
            id: _qt_node3_transform_base_group
            Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0.707107, -0.707107, 0.707107, 0.707107, 24.07, 309.89)}
        }
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node3_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 340.11 103.89 L 432.11 103.89 L 432.11 147.89 L 340.11 147.89 L 340.11 103.89 " }
        }
    }
    Shape {
        id: _qt_node4
        transformOrigin: Item.TopLeft
        transform: TransformGroup {
            id: _qt_node4_transform_base_group
            Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0.707107, -0.707107, 0.707107, 0.707107, -236.14, 202.1)}
        }
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node4_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 79.89 364.11 L 171.89 364.11 L 171.89 408.11 L 79.89 408.11 L 79.89 364.11 " }
        }
    }
    Shape {
        id: _qt_node5
        transformOrigin: Item.TopLeft
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node5_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 394 234 L 486 234 L 486 278 L 394 278 L 394 234 " }
        }
    }
    Shape {
        id: _qt_node6
        transformOrigin: Item.TopLeft
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node6_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 26 234 L 118 234 L 118 278 L 26 278 L 26 234 " }
        }
    }
    Shape {
        id: _qt_node7
        transformOrigin: Item.TopLeft
        transform: TransformGroup {
            id: _qt_node7_transform_base_group
            Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0.707107, -0.707107, 0.707107, 0.707107, -159.93, 386.11)}
        }
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node7_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 364.11 340.11 L 408.11 340.11 L 408.11 432.11 L 364.11 432.11 L 364.11 340.11 " }
        }
    }
    Shape {
        id: _qt_node8
        transformOrigin: Item.TopLeft
        transform: TransformGroup {
            id: _qt_node8_transform_base_group
            Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0.707107, -0.707107, 0.707107, 0.707107, -52.15, 125.89)}
        }
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node8_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 103.89 79.89 L 147.89 79.89 L 147.89 171.89 L 103.89 171.89 L 103.89 79.89 " }
        }
    }
    Shape {
        id: _qt_node9
        transformOrigin: Item.TopLeft
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_node9_fill_stroke
            strokeColor: "transparent"
            fillColor: color
            fillRule: ShapePath.WindingFill
            PathSvg { path: "M 256 358 C 199.667 358 154 312.333 154 256 C 154 199.667 199.667 154 256 154 C 312.333 154 358 199.667 358 256 C 357.934 312.306 312.306 357.934 256 358 " }
        }
    }
}
