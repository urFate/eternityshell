import QtQuick

import eternityshell.theme

Rectangle {
    id: root

    property string title: "Folder"
    property var appIndexes: []
    property var appModel
    property bool visibleInView: true
    property bool pageVisible: true
    property real folderProgress: 0
    property real glassOpacity: 0.78
    property real glassBlur: 0.2

    visible: root.pageVisible && root.visibleInView
    opacity: 1 - root.folderProgress * 0.5

    transform: Scale {
        origin.x: root.width / 2
        origin.y: root.height / 2
        xScale: 1 - root.folderProgress * 0.12
        yScale: 1 - root.folderProgress * 0.12
    }
    signal clicked()

    color: Qt.rgba(Theme.surface.r, Theme.surface.g,
                   Theme.surface.b, root.glassOpacity)
    radius: 2
    border.color: Theme.divider
    border.width: 1

    Grid {
        anchors {
            fill: parent
            margins: Math.max(8, width * 0.08)
        }
        columns: appIndexes.length > 4 ? 3 : 2
        rows: columns
        spacing: Math.max(4, root.width * 0.025)

        Repeater {
            model: root.appIndexes

            Rectangle {
                width: (root.width - parent.spacing * (parent.columns - 1)
                        - root.width * 0.16) / parent.columns
                height: width
                color: Theme.surfaceLight

                Image {
                    anchors.centerIn: parent
                    width: parent.width * 0.62
                    height: width
                    source: {
                        var entry = root.appModel ? root.appModel.app(modelData) : {}
                        return entry.iconPath ? "file://" + entry.iconPath : ""
                    }
                    fillMode: Image.PreserveAspectFit
                    visible: status === Image.Ready
                }

                Text {
                    anchors.centerIn: parent
                    text: "•"
                    color: Theme.accent
                    font.pixelSize: 22
                    visible: false
                }
            }
        }
    }

    Text {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 8
        }
        text: root.title
        color: Theme.text
        font.pixelSize: Math.max(12, Math.min(17, root.width * 0.06))
        elide: Text.ElideRight
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
