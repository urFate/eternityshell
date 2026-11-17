import QtQuick

import eternityshell.theme
import eternityshell.components

Item {
    id: appsPanel

    property bool appsVisible: false
    property bool shadeVisible: false
    property real shellStatusBarHeight: 0
    property string wallpaperUrl: ""
    property Item wallpaperSource
    property rect wallpaperRect: Qt.rect(0, 0, 0, 0)
    property real wallpaperDim: 0.12
    property real wallpaperBlur: 0.1

    property bool closing: false
    property bool dragging: false
    property real dragX: 0

    signal closeApps()
    signal launchApp(string name)

    visible: (appsVisible || closing || dragging) && !shadeVisible

    function beginHomeDrag() {
        appsCloseTimer.stop()
        closing = false
        dragging = true
        dragX = 0
        appsMegaTile.slideX = width
    }

    function updateHomeDrag(x) {
        dragX = x
        appsMegaTile.slideX = Math.max(0, Math.min(width, width + x))
    }

    function finishHomeDrag(open) {
        dragging = false
        if (open) {
            appsMegaTile.slideX = 0
        } else {
            closing = true
            appsMegaTile.slideX = width
            appsCloseTimer.start()
        }
    }

    Rectangle {
        id: appsMegaTile

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        color: "transparent"

        property real slideX: parent.width

        transform: Translate {
            x: appsMegaTile.slideX
        }

        GlassBackdrop {
            anchors.fill: parent
            z: -1
            sourceItem: appsPanel.backdropSource
            sourceRect: appsPanel.backdropRect
            wallpaperDim: appsPanel.wallpaperDim
            blurAmount: appsPanel.wallpaperBlur
            blurProgress: Math.max(0, Math.min(1,
                1 - appsMegaTile.slideX / Math.max(1, appsMegaTile.width)))
            tintColor: Theme.background
            tintOpacity: 0.8
        }

        Behavior on slideX {
            enabled: !appsPanel.dragging

            NumberAnimation {
                duration: 420
                easing.type: Easing.OutCubic
            }
        }

        Column {
            anchors.fill: parent
            spacing: 0
            topPadding: shellStatusBarHeight

            // Item {
            //     width: parent.width
            //     height: appsPanel.shellStatusBarHeight
            // }

            AppsList {
                width: parent.width
                height: parent.height

                onAppSelected: (name) => appsPanel.launchApp(name)
            }
        }
    }

    property Item backdropSource
    property rect backdropRect: Qt.rect(0, 0, width, height)

    DragHandler {
        target: null

        xAxis.enabled: true
        yAxis.enabled: false

        onActiveChanged: {
            if (active)
                return

            if (translation.x > 70)
                appsPanel.closeApps()
        }
    }

    Connections {
        target: appsPanel

        function onAppsVisibleChanged() {
            if (appsPanel.appsVisible) {
                appsPanel.closing = false
                if (!appsPanel.dragging) {
                    appsMegaTile.slideX = appsMegaTile.parent.width
                    Qt.callLater(function() {
                        appsMegaTile.slideX = 0
                    })
                }
            } else {
                appsPanel.closing = true
                appsMegaTile.slideX = appsMegaTile.parent.width
                appsCloseTimer.start()
            }
        }
    }

    Timer {
        id: appsCloseTimer
        interval: 420
        onTriggered: appsPanel.closing = false
    }

    Component.onCompleted: appsMegaTile.slideX = appsMegaTile.parent.width
}
