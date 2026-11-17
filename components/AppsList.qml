import QtQuick
import eternityshell.theme

Item {
    id: root

    signal appSelected(string name)

    readonly property int tileSize: 42
    readonly property int rowHeight: 58
    readonly property int headerHeight: 48

    implicitWidth: 320
    implicitHeight: 400

    TouchFlickable {
        id: listFlick

        anchors.fill: parent

        contentWidth: width
        contentHeight: listColumn.height

        bottomMargin: Theme.navBarHeight * 2

        Column {
            id: listColumn

            width: listFlick.width

            spacing: 0

            topPadding: 6

            Item {
                width: parent.width
                height: 68

                Rectangle {
                    id: searchButton

                    anchors {
                        right: parent.right
                        rightMargin: 12
                        verticalCenter: parent.verticalCenter
                    }

                    width: 46
                    height: 46

                    radius: 26

                    color: "transparent"

                    border.color: Theme.text
                    border.width: 2

                    scale: searchMouse.pressed ? 0.92 : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: 90
                        }
                    }

                    SvgIcon {
                        anchors.centerIn: parent

                        name: "search-sharp"
                        width: 22
                        height: 22
                    }

                    MouseArea {
                        id: searchMouse

                        anchors.fill: parent
                    }
                }
            }

            Repeater {
                model: desktopApps
                
                delegate: Item {
                    id: appRow

                    width: listColumn.width

                    height: root.rowHeight

                    scale: rowMouse.pressed ? 0.93 : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutBack
                            easing.overshoot: 1.4
                        }
                    }

                    Row {
                        anchors {
                            left: parent.left
                            leftMargin: 12
                            verticalCenter: parent.verticalCenter
                        }

                        spacing: 18

                        Rectangle {
                            width: root.tileSize
                            height: root.tileSize

                            color:
                                Theme.surface

                            border.color:
                                "transparent"

                            border.width:
                                0

                            Text {
                                anchors.centerIn: parent

                                text: ""
                            }

                            SvgIcon {
                                anchors.centerIn: parent
                                color: Theme.accent

                                visible: !iconPath
                                name: "apps-sharp"

                                width: 22
                                height: 22
                            }

                            Image {
                                anchors.centerIn: parent
                                visible: !!iconPath
                                source: iconPath ? "file://" + iconPath : ""
                                width: 26
                                height: 26
                                fillMode: Image.PreserveAspectFit
                                sourceSize: Qt.size(64, 64)
                            }
                        }

                        Text {
                            text: name

                            color: Theme.text

                            font.pixelSize: 20
                            font.weight: Font.Light

                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Rectangle {
                        anchors.fill: parent

                        color: "#000000"
                        opacity: rowMouse.pressed ? 0.18 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 90
                            }
                        }
                    }

                    MouseArea {
                        id: rowMouse

                        anchors.fill: parent

                        onClicked: {
                            desktopApps.launch(index)
                            root.appSelected(name)
                        }
                    }
                }
            }
        }
    }
}
