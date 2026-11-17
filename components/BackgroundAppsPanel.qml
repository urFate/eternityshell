import QtQuick

import QtWayland.Compositor

import eternityshell.theme
import eternityshell.components

Rectangle {
    id: backgroundAppsPanel

    property bool backgroundAppsVisible: false
    property real shellStatusBarHeight: 0
    property real navBarHeight: 0
    property int pageMargin: 20
    property real surfaceAspectRatio: 0.5
    property string wallpaperUrl: ""
    property Item wallpaperSource
    property rect wallpaperRect: Qt.rect(0, 0, 0, 0)
    property real wallpaperDim: 0.12
    property real wallpaperBlur: 0.25

    property var surfaceModel: []
    property int focusedIndex: -1

    signal surfaceFocused(int index)
    signal surfaceClosed(int index)

    z: 180

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    visible: backgroundAppsVisible || backgroundAppsTranslate.x > -width

    transform: Translate {
        id: backgroundAppsTranslate

        x: backgroundAppsPanel.backgroundAppsVisible
           ? 0
           : -backgroundAppsPanel.width

        Behavior on x {
            NumberAnimation {
                duration: 360
                easing.type: Easing.OutCubic
            }
        }
    }

    color: "transparent"

    GlassBackdrop {
        anchors.fill: parent
        z: -1
        sourceItem: backgroundAppsPanel.backdropSource
        sourceRect: backgroundAppsPanel.backdropRect
        wallpaperDim: backgroundAppsPanel.wallpaperDim
        blurAmount: backgroundAppsPanel.wallpaperBlur
        blurProgress: Math.max(0, Math.min(1,
            1 + backgroundAppsTranslate.x / Math.max(1, backgroundAppsPanel.width)))
        tintColor: Theme.background
        tintOpacity: 0.66
    }

    property Item backdropSource
    property rect backdropRect: Qt.rect(0, 0, width, height)

    property var backgroundEntries: {
        var result = []
        for (var i = 0; i < surfaceModel.length; i++) {
            if (i !== focusedIndex)
                result.push({ index: i, entry: surfaceModel[i] })
        }
        return result
    }

    Item {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: shellStatusBarHeight + 16
            leftMargin: backgroundAppsPanel.pageMargin
            rightMargin: backgroundAppsPanel.pageMargin
        }
        height: 52

        Text {
            id: backgroundAppsTitle
            anchors {
                left: parent.left
                right: parent.rig
                verticalCenter: parent.verticalCenter
                rightMargin: 16
            }

            text: "background applications"
            color: Theme.text
            font.pixelSize: Math.max(26, Math.min(36, backgroundAppsPanel.width * 0.075))
            font.weight: Font.Light
            elide: Text.ElideRight
        }
    }

    Flickable {
        id: backgroundAppsFlick

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 18
            bottomMargin: 20
        }

        clip: true
        interactive: true
        acceptedButtons: Qt.LeftButton
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds
        boundsMovement: Flickable.StopAtBounds

        contentWidth: backgroundWindowsGrid.x + backgroundWindowsGrid.width
                      + backgroundAppsPanel.pageMargin
        contentHeight: height

        Text {
            parent: backgroundAppsFlick
            anchors.centerIn: parent

            visible: backgroundEntries.length === 0
            text: "No background applications"
            color: Theme.mutedText
            font.pixelSize: 13
        }

        Grid {
            id: backgroundWindowsGrid

            x: backgroundAppsPanel.pageMargin
            height: backgroundAppsFlick.height
            rows: 2
            flow: Grid.TopToBottom
            rowSpacing: 12
            columnSpacing: 12

            property real cardHeight:
                (backgroundAppsFlick.height - rowSpacing) / 2
            property real cardWidth:
                cardHeight * backgroundAppsPanel.surfaceAspectRatio
            readonly property int columnCount:
                Math.ceil(backgroundWindowsRepeater.count / rows)

            width: columnCount * cardWidth
                   + Math.max(0, columnCount - 1) * columnSpacing

            Repeater {
                id: backgroundWindowsRepeater

                model: backgroundEntries.length

                delegate: Item {
                    id: surfaceCard

                    width: backgroundWindowsGrid.cardWidth
                    height: backgroundWindowsGrid.cardHeight

                    property var entryData: backgroundEntries[index]

                    Rectangle {
                        anchors.fill: parent
                        color: "#1a1a1a"
                        radius: 6
                        clip: true

                        // Live surface preview
                        WaylandQuickItem {
                            anchors.fill: parent

                            surface: entryData.entry.xdgSurface
                                     ? entryData.entry.xdgSurface.surface
                                     : null
                            inputEventsEnabled: false
                            touchEventsEnabled: false
                            focusOnClick: false
                        }

                        // Title bar overlay
                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                            }

                            height: 28
                            color: "#cc000000"

                            Text {
                                anchors {
                                    left: parent.left
                                    verticalCenter: parent.verticalCenter
                                    leftMargin: 8
                                    rightMargin: 32
                                }

                                text: entryData.entry.title || "Untitled"
                                color: "#ffffff"
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                elide: Text.ElideRight
                            }

                            // Close button
                            Item {
                                anchors {
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                    rightMargin: 4
                                }

                                width: 24
                                height: 24

                                Text {
                                    anchors.centerIn: parent
                                    text: "×"
                                    color: "#ffffff"
                                    font.pixelSize: 18
                                    font.weight: Font.Light
                                }

                                MouseArea {
                                    anchors.fill: parent

                                        onClicked: {
                                            surfaceClosed(entryData.index)
                                        }
                                    }
                                }
                            }

                        // Tap to focus
                        MouseArea {
                            anchors.fill: parent
                            anchors.topMargin: 28

                            onClicked: {
                                surfaceFocused(entryData.index)
                            }
                        }
                    }
                }
            }
        }

        WheelHandler {
            onWheel: (event) => {
                var wheelDelta = event.angleDelta.x !== 0
                    ? event.angleDelta.x
                    : event.angleDelta.y
                var delta = wheelDelta / 8

                backgroundAppsFlick.contentX = Math.max(
                    0,
                    Math.min(
                        backgroundAppsFlick.contentWidth - backgroundAppsFlick.width,
                        backgroundAppsFlick.contentX - delta
                    )
                )
                event.accepted = true
            }
        }
    }
}
