import QtQuick
import eternityshell.theme

Rectangle {
    id: root

    property string title: ""
    property string subtitle: ""
    property string icon: ""
    property string iconPath: ""

    property var appModel
    property int modelIndex: -1
    property var layoutGrid
    property real dragOffsetX: 0
    property real dragOffsetY: 0
    property bool dragging: false
    property real folderProgress: 0
    property int dragStartIndex: -1
    property int dragTargetIndex: -1
    property real glassOpacity: 0.78
    property real glassBlur: 0.2
    property Item blurredWallpaperSource
    property rect blurredWallpaperRect: Qt.rect(0, 0, root.width, root.height)

    property color tileColor: Theme.accent
    property color foregroundColor: Theme.surface

    property int tileColumn: 0
    property int tileRow: 0

    property real hintOffset: 0

    property bool pageVisible: true
    property bool visibleInView: true

    readonly property bool metroActive: pageVisible && visibleInView

    property real metroRotY: -82
    property real metroTranslateX: 0
    property real metroOpacity: 0

    property real pressScale: 1
    property real pressBrightness: 0

    property bool widgetActive: false
    property Component widgetContent: null

    property bool initialEnterDone: false
    property bool _pageWasHidden: false

    signal clicked()

    color: "transparent"

    opacity: metroOpacity

    readonly property real edgeMargin: Math.max(12, root.width * 0.055)

    readonly property int enterDelay:
        tileColumn * 65 + tileRow * 28

    readonly property int exitDelay:
        tileColumn * 45 + tileRow * 18

    layer.enabled:
        metroEnterAnimation.running ||
        metroRestoreAnimation.running ||
        metroExitAnimation.running
    layer.smooth: true

    transform: [
        Translate {
            x: root.dragOffsetX + root.folderProgress
               * (root.tileColumn === 0 ? -root.width * 0.9 : root.width * 0.9)
            y: root.dragOffsetY + root.folderProgress
               * (root.tileRow === 0 ? -root.height * 0.7 : root.height * 0.7)
        },
        Translate {
            x: root.metroTranslateX
            y: root.hintOffset
        },

        Rotation {
            origin.x: root.width / 2
            origin.y: root.height / 2

            axis {
                x: 0
                y: 1
                z: 0
            }

            angle: root.metroRotY
        },

        Scale {
            origin.x: root.width / 2
            origin.y: root.height / 2

            xScale: root.pressScale
            yScale: root.pressScale
        }
    ]

    Behavior on x {
        enabled: !root.dragging
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on y {
        enabled: !root.dragging
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on dragOffsetX {
        enabled: !root.dragging
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on dragOffsetY {
        enabled: !root.dragging
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on pressScale {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutBack
            easing.overshoot: 1.4
        }
    }

    Behavior on hintOffset {
        NumberAnimation {
            duration: 420
            easing.type: Easing.InOutQuad
        }
    }

    Item {
        id: clipFrame
        anchors.fill: parent
        clip: true

        property real frontTileRotY: 0
        property real backTileRotY: -82

        Rectangle {
            id: frontTile
            width: clipFrame.width
            height: clipFrame.height
            y: 0
            opacity: 1
            Rectangle {
                anchors.fill: parent
                color: "transparent"

                ShaderEffectSource {
                    anchors.fill: parent
                    sourceItem: root.blurredWallpaperSource
                    sourceRect: root.blurredWallpaperRect
                    textureSize: Qt.size(Math.max(1, root.width), Math.max(1, root.height))
                    live: true
                    hideSource: false
                    visible: !!root.blurredWallpaperSource && root.glassBlur > 0
                }

                Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(root.tileColor.r, root.tileColor.g,
                                   root.tileColor.b, root.glassOpacity)
                }
            }

            transform: Rotation {
                axis: Qt.vector3d(0, 1, 0)
                angle: clipFrame.frontTileRotY
                origin.x: frontTile.width
                origin.y: frontTile.height / 2
            }

            SvgIcon {
                id: iconText

                anchors.centerIn: parent
                color: root.foregroundColor

                name: root.icon
                width: Math.max(
                    46,
                    Math.min(80, root.width * 0.16)
                )
                height: width
                visible: !root.iconPath || appIcon.status !== Image.Ready
            }

            Image {
                id: appIcon
                anchors.centerIn: parent
                width: Math.max(46, Math.min(80, root.width * 0.16))
                height: width
                source: root.iconPath ? "file://" + root.iconPath : ""
                fillMode: Image.PreserveAspectFit
                sourceSize: Qt.size(128, 128)
                visible: root.iconPath !== "" && status === Image.Ready
            }

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom

                    leftMargin: root.edgeMargin
                    rightMargin: root.edgeMargin
                    bottomMargin: root.edgeMargin
                }

                spacing: 2

                Text {
                    width: parent.width

                    text: root.title

                    color: root.foregroundColor

                    font.pixelSize: Math.max(
                        17,
                        Math.min(32, root.width * 0.075)
                    )

                    font.weight: Font.Light

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width

                    text: root.subtitle

                    color: "#dddddd"

                    font.pixelSize: Math.max(
                        11,
                        Math.min(20, root.width * 0.045)
                    )

                    elide: Text.ElideRight
                }
            }
        }

        Rectangle {
            id: backTile
            width: clipFrame.width
            height: clipFrame.height
            y: 0
            opacity: 0
            color: Qt.rgba(root.tileColor.r, root.tileColor.g,
                           root.tileColor.b, root.glassOpacity)

            transform: Rotation {
                axis: Qt.vector3d(0, 1, 0)
                angle: clipFrame.backTileRotY
                origin.x: backTile.width / 2
                origin.y: backTile.height / 2
            }

            Loader {
                id: backTileLoader
                anchors.fill: parent
                sourceComponent: root.widgetContent
            }
        }
    }

    Rectangle {
        anchors.fill: parent

        color: "#000000"

        opacity: root.pressBrightness

        Behavior on opacity {
            NumberAnimation {
                duration: 90
            }
        }
    }

    onMetroActiveChanged: {
        if (metroActive) {
            metroExitAnimation.stop()
            flipToWidget.stop()
            flipToNormal.stop()
            clipFrame.frontTileRotY = 0
            frontTile.opacity = 1
            clipFrame.backTileRotY = -82
            backTile.opacity = 0
            widgetActive = false

            if (!initialEnterDone) {
                metroEnterAnimation.start()
            } else if (_pageWasHidden) {
                metroRestoreAnimation.start()
            } else {
                metroRotY = 0
                metroTranslateX = 0
                metroOpacity = 1
            }
        } else {
            metroEnterAnimation.stop()
            metroRestoreAnimation.stop()
            metroExitAnimation.start()
            _pageWasHidden = !pageVisible
        }
    }

    onWidgetActiveChanged: {
        if (widgetActive && metroActive && !flipToWidget.running)
            flipToWidget.start()
        else if (!widgetActive && !flipToNormal.running)
            flipToNormal.start()
    }

    ParallelAnimation {
        id: metroEnterAnimation

        SequentialAnimation {
            PauseAnimation {
                duration: root.enterDelay
            }

            ParallelAnimation {
                NumberAnimation {
                    target: root
                    property: "metroRotY"

                    from: -82
                    to: 0

                    duration: 480

                    easing.type: Easing.OutCubic
                }

                NumberAnimation {
                    target: root
                    property: "metroTranslateX"

                    from: -root.width * 0.55
                    to: 0

                    duration: 480

                    easing.type: Easing.OutCubic
                }

                NumberAnimation {
                    target: root
                    property: "metroOpacity"

                    from: 0
                    to: 1

                    duration: 280

                    easing.type: Easing.OutCubic
                }
            }

            ScriptAction {
                script: root.initialEnterDone = true
            }
        }
    }

    ParallelAnimation {
        id: metroRestoreAnimation

        NumberAnimation {
            target: root
            property: "metroRotY"
            to: 0
            duration: 340
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            target: root
            property: "metroTranslateX"
            to: 0
            duration: 340
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            target: root
            property: "metroOpacity"
            to: 1
            duration: 220
            easing.type: Easing.OutCubic
        }
    }

    ParallelAnimation {
        id: metroExitAnimation

        NumberAnimation {
            target: root
            property: "metroRotY"
            to: -82
            duration: 360
            easing.type: Easing.InOutCubic
        }

        NumberAnimation {
            target: root
            property: "metroTranslateX"
            to: -root.width * 0.55
            duration: 360
            easing.type: Easing.InOutCubic
        }

        NumberAnimation {
            target: root
            property: "metroOpacity"
            to: 0
            duration: 260
            easing.type: Easing.InOutCubic
        }
    }

    SequentialAnimation {
        id: flipToWidget

        ParallelAnimation {
            NumberAnimation {
                target: clipFrame
                property: "frontTileRotY"
                to: 78
                duration: 340
                easing.type: Easing.InCubic
            }

            NumberAnimation {
                target: frontTile
                property: "opacity"
                to: 0
                duration: 220
                easing.type: Easing.InCubic
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: clipFrame
                property: "backTileRotY"
                from: -82
                to: 0
                duration: 480
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: backTile
                property: "opacity"
                from: 0
                to: 1
                duration: 280
                easing.type: Easing.OutCubic
            }
        }
    }

    SequentialAnimation {
        id: flipToNormal

        ParallelAnimation {
            NumberAnimation {
                target: clipFrame
                property: "backTileRotY"
                to: 78
                duration: 340
                easing.type: Easing.InCubic
            }

            NumberAnimation {
                target: backTile
                property: "opacity"
                to: 0
                duration: 220
                easing.type: Easing.InCubic
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: clipFrame
                property: "frontTileRotY"
                from: -82
                to: 0
                duration: 480
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: frontTile
                property: "opacity"
                from: 0
                to: 1
                duration: 280
                easing.type: Easing.OutCubic
            }
        }
    }

    Component.onCompleted: {
        metroRotY = -82
        metroTranslateX = -width * 0.55
        metroOpacity = 0

        if (metroActive)
            metroEnterAnimation.start()
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onPressed: {
            root.pressScale = 0.93
            root.pressBrightness = 0.18
        }

        onReleased: {
            root.pressScale = 1
            root.pressBrightness = 0
        }

        onCanceled: {
            root.pressScale = 1
            root.pressBrightness = 0
        }

        onClicked: {
            if (root.widgetActive) {
                root.widgetActive = false
            } else {
                root.clicked()
            }
        }
    }

    DragHandler {
        target: null
        grabPermissions: PointerHandler.CanTakeOverFromAnything

        onActiveChanged: {
            if (active) {
                root.dragging = true
                root.dragStartIndex = root.modelIndex
                root.dragTargetIndex = root.modelIndex
                root.z = 20
                return
            }

            root.z = 0
            root.dragOffsetX = 0
            root.dragOffsetY = 0
            root.dragging = false
            root.dragStartIndex = -1
            root.dragTargetIndex = -1
        }

        onTranslationChanged: {
            if (!active || !root.layoutGrid || root.modelIndex < 0 || !root.appModel)
                return

            if (root.dragStartIndex < 0) {
                root.dragStartIndex = root.modelIndex
                root.dragTargetIndex = root.modelIndex
            }

            root.dragOffsetX = translation.x
            root.dragOffsetY = translation.y

            var cellWidth = root.width + root.layoutGrid.spacing
            var cellHeight = root.height + root.layoutGrid.spacing
            var columnDelta = Math.round(translation.x / cellWidth)
            var rowDelta = Math.round(translation.y / cellHeight)
            var targetIndex = root.dragStartIndex
                              + rowDelta * root.layoutGrid.columns
                              + columnDelta
            targetIndex = Math.max(0, Math.min(root.appModel.count - 1, targetIndex))

            if (targetIndex !== root.dragTargetIndex) {
                root.appModel.move(root.dragTargetIndex, targetIndex)
                root.dragTargetIndex = targetIndex
            }
        }
    }
}
