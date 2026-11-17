import QtQuick
import QtQuick.Effects

import eternityshell.theme

Rectangle {
    id: root

    property bool folderVisible: false
    property string folderTitle: "Folder"
    property var appIndexes: []
    property var appModel
    property string wallpaperUrl: ""
    property real wallpaperDim: 0.12
    property real wallpaperBlur: 0.25

    signal closeRequested()

    z: 220
    color: "transparent"
    visible: folderVisible
    opacity: folderVisible ? Math.max(0, Math.min(1, folderProgress)) : 0
    property real folderProgress: 0

    Image {
        id: folderWallpaperImage
        anchors.fill: parent
        z: -2
        source: root.wallpaperUrl
        fillMode: Image.PreserveAspectCrop
        opacity: 1
    }

    MultiEffect {
        anchors.fill: parent
        source: folderWallpaperImage
        blurEnabled: root.wallpaperBlur > 0
        blur: root.wallpaperBlur
        z: -2
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Qt.rgba(Theme.background.r, Theme.background.g,
                       Theme.background.b, 0.82)
    }

    Text {
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 26
            leftMargin: 28
        }
        text: root.folderTitle
        color: Theme.text
        font.pixelSize: 34
        font.weight: Font.Light
        z: 1
    }

    Text {
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 34
            rightMargin: 28
        }
        text: root.appIndexes.length + " apps"
        color: Theme.secondaryText
        font.pixelSize: 13
        z: 1
    }

    Grid {
        id: appGrid
        anchors.centerIn: parent
        columns: root.appIndexes.length > 4 ? 3 : 2
        spacing: 12
        z: 1

        Repeater {
            model: root.appIndexes

            Rectangle {
                width: Math.min(150, (root.width - 84) / appGrid.columns)
                height: width
                color: Theme.surface
                border.color: Theme.divider
                border.width: 1

                Image {
                    id: appIcon
                    anchors.centerIn: parent
                    width: parent.width * 0.42
                    height: width
                    source: {
                        var entry = root.appModel ? root.appModel.app(modelData) : {}
                        return entry.iconPath ? "file://" + entry.iconPath : ""
                    }
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        margins: 10
                    }
                    text: {
                        var entry = root.appModel ? root.appModel.app(modelData) : {}
                        return entry.name || "Application"
                    }
                    color: Theme.text
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.appModel.launch(modelData)
                        root.closeRequested()
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        z: 0
        onClicked: root.closeRequested()
    }
}
