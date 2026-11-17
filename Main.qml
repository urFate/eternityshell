import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Window

import QtWayland.Compositor
import QtWayland.Compositor.XdgShell
import QtWayland.Compositor.WlShell

import eternityshell.theme
import eternityshell.components

WaylandCompositor {
    id: compositor

    socketName: "eternityshell"

    property var shellSurfaces: []
    property int focusedIndex: -1
    property var closedApps: []
    property bool _userClosing: false

    signal appCrashed(int index, string title, string appId)
    signal appClosed(int index, string title, string appId)

    property bool appsVisible: false
    property bool shadeVisible: false
    property bool backgroundAppsVisible: false
    property bool folderVisible: false
    property bool folderTransitioning: false
    property bool folderClosing: false
    property real folderProgress: 0
    property string folderTitle: ""
    property var folderAppIndexes: []
    property bool appLaunchActive: false

    property int batteryLevel: 82

    property bool wifiEnabled: true
    property int wifiStrength: 3

    property bool cellularEnabled: true
    property int cellularStrength: 4
    property string operatorName: "AT&T"

    property bool bluetoothEnabled: true
    property bool silentMode: false

    property int unreadNotifications: 3

    property string currentTime: ""
    property string currentDate: ""

    property bool amoledHintActive: false

    readonly property bool hasFocusedApp:
        focusedIndex >= 0 && focusedIndex < shellSurfaces.length

    XdgShell {
        onToplevelCreated: (toplevel, xdgSurface) => {
            var entry = {
                xdgSurface: xdgSurface,
                toplevel: toplevel,
                title: toplevel.title || "Untitled",
                appId: toplevel.appId || ""
            }
            compositor.shellSurfaces = compositor.shellSurfaces.concat([entry])
            compositor.focusedIndex = compositor.shellSurfaces.length - 1

            toplevel.titleChanged.connect(function() {
                entry.title = toplevel.title || "Untitled"
                compositor.shellSurfacesChanged()
            })
        }
    }

    XdgDecorationManagerV1 {
        preferredMode: XdgToplevel.ServerSideDecoration
    }

    function focusApp(index) {
        if (index >= 0 && index < shellSurfaces.length)
            focusedIndex = index
    }

    function closeApp(index) {
        if (index < 0 || index >= shellSurfaces.length)
            return
        var entry = shellSurfaces[index]
        appClosed(index, entry.title, entry.appId)
        closedApps = closedApps.concat([{ title: entry.title, appId: entry.appId, timestamp: Date.now() }])
        _userClosing = true
        entry.toplevel.sendClose()
        var arr = shellSurfaces
        arr.splice(index, 1)
        shellSurfaces = arr
        if (focusedIndex >= shellSurfaces.length)
            focusedIndex = shellSurfaces.length - 1
        _userClosing = false
    }

    function openApps() {
        appsVisible = true
        shadeVisible = false
        backgroundAppsVisible = false
    }

    function closeApps() {
        appsVisible = false
    }

    function launchApp(name) {
        console.log("Launch:", name)
        appLaunchActive = true
        closeApps()
        appLaunchResetTimer.restart()
    }

    function launchDesktopApp(index) {
        if (index < 0 || index >= desktopApps.count)
            return

        desktopApps.launch(index)
        appLaunchActive = true
        closeApps()
        appLaunchResetTimer.restart()
    }

    function openBackgroundApps() {
        backgroundAppsVisible = !backgroundAppsVisible
        if (backgroundAppsVisible) {
            appsVisible = false
            shadeVisible = false
        }
    }

    function openFolder(title, indexes) {
        folderOpenAnimation.stop()
        folderCloseAnimation.stop()
        folderTitle = title
        folderAppIndexes = indexes
        folderClosing = false
        folderTransitioning = true
        folderProgress = 0
        folderVisible = true
        appsVisible = false
        shadeVisible = false
        backgroundAppsVisible = false
        folderOpenAnimation.start()
    }

    function closeFolder() {
        if (!folderVisible || folderClosing)
            return
        folderOpenAnimation.stop()
        folderClosing = true
        folderTransitioning = true
        folderCloseAnimation.start()
    }

    function closeBackgroundApps() {
        backgroundAppsVisible = false
    }

    function openShade() {
        appsVisible = false
        backgroundAppsVisible = false
        shadeVisible = true
    }

    function closeShade() {
        shadeVisible = false
    }

    function goHome() {
        appsVisible = false
        shadeVisible = false
        backgroundAppsVisible = false
        closeFolder()
        if (hasFocusedApp)
            focusedIndex = -1
    }

    function updateClock() {
        var now = new Date()
        currentTime = Qt.formatTime(now, "HH:mm")
        currentDate = Qt.formatDate(now, "dddd, d MMMM")
    }

    function resetAmoledTimer() {
        amoledHintActive = false
        amoledTimer.restart()
    }

    NumberAnimation {
        id: folderOpenAnimation
        target: compositor
        property: "folderProgress"
        from: 0
        to: 1
        duration: 480
        easing.type: Easing.OutCubic
        onFinished: compositor.folderTransitioning = false
    }

    NumberAnimation {
        id: folderCloseAnimation
        target: compositor
        property: "folderProgress"
        from: 1
        to: 0
        duration: 360
        easing.type: Easing.InCubic
        onFinished: {
            compositor.folderVisible = false
            compositor.folderTransitioning = false
            compositor.folderClosing = false
            compositor.folderAppIndexes = []
        }
    }

    // ==================================================
    // OUTPUT — wraps the main Window
    // ==================================================

    WaylandOutput {
        id: mainOutput
        sizeFollowsWindow: true

        window: Window {
            id: mainWindow

            visible: true
            width: 450
            height: 900
            minimumWidth: 320
            minimumHeight: 480
            title: "Eternity Shell"
            color: Theme.background

            readonly property bool phoneMode:
                width < 700

            readonly property int pageMargin:
                Math.max(20, Math.min(38, width * 0.065))

            readonly property int tileGap:
                Math.max(6, Math.min(10, width * 0.018))

            readonly property bool homeActive:
                !compositor.appsVisible && !compositor.shadeVisible
                && !compositor.backgroundAppsVisible && !compositor.folderVisible

            Item {
                id: backdropScene

                anchors.fill: parent
                z: -100
            }

            Image {
                 id: sharedWallpaper
                 parent: backdropScene
                 anchors.fill: parent
                 source: shellConfig.wallpaperUrl
                 fillMode: Image.PreserveAspectCrop
                 z: -1
             }

            Component.onCompleted: {
                compositor.updateClock()
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: compositor.updateClock()
            }

            Timer {
                id: appLaunchResetTimer
                interval: 700
                onTriggered: compositor.appLaunchActive = false
            }

            Timer {
                id: amoledTimer
                interval: 30000
                repeat: false
                running: !compositor.appsVisible && !compositor.shadeVisible
                onTriggered: {
                    compositor.amoledHintActive = true
                    hintAnimation.start()
                }
            }

            Connections {
                target: compositor
                function onAppsVisibleChanged() {
                    if (!compositor.appsVisible)
                        compositor.resetAmoledTimer()
                    else
                        amoledTimer.stop()
                }
                function onShadeVisibleChanged() {
                    if (!compositor.shadeVisible && !compositor.appsVisible)
                        compositor.resetAmoledTimer()
                }
            }

            Item {
                id: cubeCamera
                parent: backdropScene
                x: mainWindow.width / 2
                y: mainWindow.height / 2
                width: 0
                height: 0
                z: 0

                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(
                        1, 0, 0, 0,
                        0, 1, 0, 0,
                        0, 0, 1, -1 / Math.max(1, mainWindow.width * 2.4),
                        0, 0, 0, 1
                    )
                }
            }

            Item {
                id: cubeViewport
                parent: cubeCamera
                x: -mainWindow.width / 2
                y: -mainWindow.height / 2
                width: mainWindow.width
                height: mainWindow.height
                clip: true
            }

            // ==================================================
            // FOCUSED APP (fullscreen, behind shell UI)
            // ==================================================

            Connections {
                target: compositor

                function onFocusedIndexChanged() {
                    focusedAppHolder.syncSurface()
                }

                function onShellSurfacesChanged() {
                    focusedAppHolder.syncSurface()
                }
            }

            Item {
                id: focusedAppHolder
                parent: cubeViewport
                anchors.fill: parent
                z: focusedAppHolder.cubeProgress >= 0.5 ? 2 : 0

                property bool appClosing: false
                property bool cubeTransitioning: false
                property real cubeProgress: 0

                visible: compositor.hasFocusedApp || appClosing || cubeTransitioning
                layer.enabled: cubeTransitioning
                layer.smooth: true

                transform: Rotation {
                    origin.x: focusedAppHolder.width
                    origin.y: focusedAppHolder.height
                    origin.z: -focusedAppHolder.width
                    axis: Qt.vector3d(0, 1, 0)
                    angle: 90 * (1 - focusedAppHolder.cubeProgress)
                }

                Connections {
                    target: compositor
                    function onHasFocusedAppChanged() {
                        if (compositor.hasFocusedApp) {
                            appCloseAnimation.stop()
                            focusedAppHolder.appClosing = false
                            focusedAppHolder.cubeTransitioning = true
                            appOpenAnimation.start()
                        } else {
                            appOpenAnimation.stop()
                            focusedAppHolder.appClosing = true
                            focusedAppHolder.cubeTransitioning = true
                            appCloseAnimation.start()
                        }
                    }
                }

                SequentialAnimation {
                    id: appOpenAnimation

                    PauseAnimation { duration: 45 }
                    NumberAnimation {
                        target: focusedAppHolder
                        property: "cubeProgress"
                        from: 0
                        to: 1
                        duration: 440
                        easing.type: Easing.InOutCubic
                    }

                    onFinished: focusedAppHolder.cubeTransitioning = false
                }

                SequentialAnimation {
                    id: appCloseAnimation

                    NumberAnimation {
                        target: focusedAppHolder
                        property: "cubeProgress"
                        from: 1
                        to: 0
                        duration: 320
                        easing.type: Easing.InOutCubic
                    }

                    onFinished: {
                        focusedAppHolder.appClosing = false
                        focusedAppHolder.cubeTransitioning = false
                        focusedSurfaceItem.shellSurface = null
                    }
                }

                function syncSurface() {
                    if (!compositor.hasFocusedApp)
                        return
                    var idx = compositor.focusedIndex
                    if (idx >= 0 && idx < compositor.shellSurfaces.length) {
                        focusedSurfaceItem.shellSurface = compositor.shellSurfaces[idx].xdgSurface
                        maximizeTimer.restart()
                    }
                }

                Timer {
                    id: maximizeTimer
                    interval: 50
                    repeat: true
                    onTriggered: {
                        var idx = compositor.focusedIndex
                        if (idx < 0 || idx >= compositor.shellSurfaces.length) {
                            stop()
                            return
                        }
                        compositor.shellSurfaces[idx].toplevel.sendMaximized(
                            Qt.size(focusedSurfaceItem.width, focusedSurfaceItem.height))
                        stop()
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.background
                    z: -2
                }

                ShellSurfaceItem {
                    id: focusedSurfaceItem
                    anchors.fill: parent
                    anchors.topMargin: shellStatusBar.height
                    anchors.bottomMargin: navBar.height
                    autoCreatePopupItems: true

                    onSurfaceDestroyed: {
                        var idx = compositor.focusedIndex
                        if (idx >= 0 && idx < compositor.shellSurfaces.length) {
                            var entry = compositor.shellSurfaces[idx]
                            if (!compositor._userClosing)
                                compositor.appCrashed(idx, entry.title, entry.appId)
                            var arr = compositor.shellSurfaces
                            arr.splice(idx, 1)
                            compositor.shellSurfaces = arr
                            if (compositor.focusedIndex >= compositor.shellSurfaces.length)
                                compositor.focusedIndex = compositor.shellSurfaces.length - 1
                        }
                    }
                }
            }

            // ==================================================
            // STATUS BAR
            // ==================================================

            StatusBar {
                id: shellStatusBar

                z: 250

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                horizontalMargin: mainWindow.pageMargin

                opacity: compositor.shadeVisible ? 0 : 1
                transparent: !hasFocusedApp

                Behavior on opacity {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }

                sourceItem: compositor.hasFocusedApp ? focusedSurfaceItem : sharedWallpaper

                time: compositor.currentTime
                batteryLevel: compositor.batteryLevel
                wifiEnabled: compositor.wifiEnabled
                cellularEnabled: compositor.cellularEnabled
                cellularStrength: compositor.cellularStrength
                silentMode: compositor.silentMode
            }

            Item {
                id: shadePullZone

                z: 260

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                height: 72
                visible: !compositor.shadeVisible

                DragHandler {
                    target: null
                    xAxis.enabled: false
                    yAxis.enabled: true

                    onTranslationChanged: {
                        if (active && translation.y > 50)
                            compositor.openShade()
                    }
                }
            }

            // ==================================================
            // AMOLED IDLE HINT
            // ==================================================

            ParallelAnimation {
                id: hintAnimation

                SequentialAnimation {
                    NumberAnimation { target: tile1; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile1; property: "hintOffset"; to: 0; duration: 350 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 70 }
                    NumberAnimation { target: tile2; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile2; property: "hintOffset"; to: 0; duration: 350 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 140 }
                    NumberAnimation { target: tile3; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile3; property: "hintOffset"; to: 0; duration: 350 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 210 }
                    NumberAnimation { target: tile4; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile4; property: "hintOffset"; to: 0; duration: 350 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 280 }
                    NumberAnimation { target: tile5; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile5; property: "hintOffset"; to: 0; duration: 350 }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 350 }
                    NumberAnimation { target: tile6; property: "hintOffset"; to: 12; duration: 350 }
                    NumberAnimation { target: tile6; property: "hintOffset"; to: 0; duration: 350 }
                }
            }

            // ==================================================
            // HOME
            // ==================================================

            Item {
                id: homePage
                parent: cubeViewport

                anchors.fill: parent

                property real cubeProgress: focusedAppHolder.cubeProgress
                z: homePage.cubeProgress < 0.5 ? 2 : 1

                visible:
                    !compositor.shadeVisible &&
                    !compositor.backgroundAppsVisible &&
                    (!compositor.folderVisible || compositor.folderTransitioning) &&
                    (!compositor.hasFocusedApp || focusedAppHolder.cubeTransitioning)

                layer.enabled: focusedAppHolder.cubeTransitioning
                layer.smooth: true

                transform: Rotation {
                    origin.x: homePage.width / 2
                    origin.y: homePage.height / 2
                    origin.z: -homePage.width / 2
                    axis: Qt.vector3d(0, 1, 0)
                    angle: -90 * homePage.cubeProgress
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    z: -1
                }

                MultiEffect {
                    id: homeWallpaperBlur
                    anchors.fill: parent
                    source: sharedWallpaper
                    blurEnabled: shellConfig.tileBlur > 0
                    blur: shellConfig.tileBlur
                    z: -1
                    opacity: 0
                }

                Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(Theme.background.r, Theme.background.g,
                                   Theme.background.b, shellConfig.wallpaperDim)
                    z: -1
                }

                TouchFlickable {
                    id: homeFlick

                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        topMargin: shellStatusBar.height + 1
                    }

                    contentWidth: width
                    contentHeight: homeContent.height
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    onMovementStarted: compositor.resetAmoledTimer()
                    onContentYChanged: compositor.resetAmoledTimer()

                    Column {
                        id: homeContent

                        width: homeFlick.width
                        spacing: 18
                        topPadding: 24
                        bottomPadding: 24 + Theme.navBarHeight

                        Item {
                            id: tileGridPerspective

                            width: parent.width
                            height: tileGrid.height
                            anchors.horizontalCenter: parent.horizontalCenter

                            transform: Matrix4x4 {
                                matrix: Qt.matrix4x4(
                                    1, 0, 0, 0,
                                    0, 1, 0, 0,
                                    0, 0, 1, -0.0014,
                                    0, 0, 0, 1
                                )
                            }

                            Grid {
                                id: tileGrid

                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width - mainWindow.pageMargin * 2
                                columns: mainWindow.phoneMode ? 2 : 4
                                spacing: mainWindow.tileGap

                                property real tileWidth: columns === 2 ? 180 : 140
                                 property real tileHeight: tileWidth

                                 function updateTileVisibility() {
                                     for (var i = 0; i < launcherRepeater.count; ++i) {
                                         var tile = launcherRepeater.itemAt(i)
                                         if (!tile)
                                             continue
                                         var pos = tile.mapToItem(homeFlick, 0, 0)
                                         tile.visibleInView =
                                            pos.y + tile.height > 0 &&
                                            pos.y < homeFlick.height
                                    }
                                }

                                 Component.onCompleted: updateTileVisibility()

                                 FolderTile {
                                     id: applicationsFolderTile
                                     width: tileGrid.tileWidth
                                     height: tileGrid.tileHeight
                                     appModel: desktopApps
                                     appIndexes: tileGrid.columns > 2
                                                 ? [0, 1, 2, 3, 4, 5, 6, 7, 8]
                                                 : [0, 1, 2, 3]
                                      title: "Applications"
                                      folderProgress: compositor.folderProgress
                                      glassOpacity: shellConfig.tileOpacity
                                      glassBlur: shellConfig.tileBlur
                                     pageVisible: !compositor.shadeVisible
                                                  && !compositor.appsVisible
                                                  && !compositor.appLaunchActive
                                                  && !compositor.backgroundAppsVisible
                                                  && !compositor.folderVisible
                                     onClicked: compositor.openFolder(
                                         "Applications",
                                         tileGrid.columns > 2
                                         ? [0, 1, 2, 3, 4, 5, 6, 7, 8]
                                         : [0, 1, 2, 3])
                                 }

                                 Repeater {
                                     id: launcherRepeater
                                     model: desktopApps

                                     delegate: Tile {
                                         width: tileGrid.tileWidth
                                         height: tileGrid.tileHeight
                                         tileColumn: (index + 1) % tileGrid.columns
                                         tileRow: Math.floor((index + 1) / tileGrid.columns)
                                         folderProgress: compositor.folderProgress
                                         title: model.name
                                         subtitle: "Application"
                                         icon: "apps-sharp"
                                         iconPath: model.iconPath
                                          tileColor: ["#0078d7", "#107c10", "#d83b01", "#5c2d91",
                                                      "#008272", "#505050", "#00a4ef", "#006b5b"][index % 8]
                                          foregroundColor: Theme.surface
                                          glassOpacity: shellConfig.tileOpacity
                                          glassBlur: shellConfig.tileBlur
                                          blurredWallpaperSource: homeWallpaperBlur
                                          blurredWallpaperRect: Qt.rect(
                                              mainWindow.pageMargin
                                              + tileColumn * (tileGrid.tileWidth + tileGrid.spacing),
                                              shellStatusBar.height + 1 + homeContent.topPadding
                                              + tileRow * (tileGrid.tileHeight + tileGrid.spacing)
                                              - homeFlick.contentY,
                                              tileGrid.tileWidth,
                                              tileGrid.tileHeight)
                                         appModel: desktopApps
                                         modelIndex: index
                                         layoutGrid: tileGrid
                                          pageVisible: !compositor.shadeVisible
                                                       && !compositor.appsVisible
                                                       && !compositor.appLaunchActive
                                                       && !compositor.backgroundAppsVisible
                                                       && !compositor.folderVisible
                                          onClicked: compositor.launchDesktopApp(index)
                                      }
                                  }

                                 Item {
                                     width: 0
                                     height: 0
                                     visible: false

                                 Component {
                                     id: weatherWidget

                                    Item {
                                        anchors.fill: parent

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 2

                                            SvgIcon {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                name: "sunny-sharp"
                                                width: 36
                                                height: 36
                                                color: "#ffffff"
                                            }

                                            Text {
                                                text: "22°"
                                                color: "#ffffff"
                                                font.pixelSize: Math.max(22, Math.min(32, parent.parent.width * 0.12))
                                                font.weight: Font.Light
                                                anchors.horizontalCenter: parent.horizontalCenter
                                            }

                                            Text {
                                                text: "Clear"
                                                color: "#dddddd"
                                                font.pixelSize: Math.max(11, Math.min(14, parent.parent.width * 0.045))
                                                anchors.horizontalCenter: parent.horizontalCenter
                                            }

                                            Row {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                spacing: 8
                                                Text { text: "↑ 25°"; color: "#cccccc"; font.pixelSize: Math.max(10, Math.min(12, parent.parent.width * 0.038)) }
                                                Text { text: "↓ 18°"; color: "#cccccc"; font.pixelSize: Math.max(10, Math.min(12, parent.parent.width * 0.038)) }
                                            }
                                        }
                                    }
                                }

                                 Tile {
                                    id: tile1
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 0; tileRow: 0
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Browser"; subtitle: "Internet"; icon: "globe-sharp"
                                    tileColor: "#0078d7"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                 Tile {
                                    id: tile2
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 0
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Messages"; subtitle: "3 new"; icon: "mail-sharp"
                                    tileColor: "#107c10"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile3
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 0; tileRow: 1
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Music"; subtitle: "Playing"; icon: "musical-notes-sharp"
                                    tileColor: "#d83b01"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile4
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 1
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Photos"; subtitle: "Gallery"; icon: "images-sharp"
                                    tileColor: "#5c2d91"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile5
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 0; tileRow: 2
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Calendar"; subtitle: "Tuesday"; icon: "calendar-sharp"
                                    tileColor: "#008272"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile6
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 2
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Settings"; subtitle: "System"; icon: "settings-sharp"
                                    tileColor: "#505050"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                 FolderTile {
                                     id: tile7
                                     width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                     appModel: desktopApps
                                     appIndexes: [0, 1, 2, 3]
                                     title: "Applications"
                                     onClicked: compositor.openFolder("Applications", [0, 1, 2, 3])
                                 }
                                Tile {
                                    id: tile8
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 3
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Terminal"; subtitle: "Linux"; icon: "terminal-sharp"
                                    tileColor: "#202020"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile9
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 0; tileRow: 4
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Weather"; subtitle: "22° / Clear"; icon: "sunny-sharp"
                                    tileColor: "#00a4ef"
                                    widgetContent: weatherWidget
                                    onClicked: compositor.resetAmoledTimer()
                                    Timer { running: true; interval: 2000; onTriggered: tile9.widgetActive = true }
                                }
                                Tile {
                                    id: tile10
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 4
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Files"; subtitle: "12 recent"; icon: "folder-sharp"
                                    tileColor: "#8a6d1d"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile11
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 0; tileRow: 5
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Camera"; subtitle: "Ready"; icon: "camera-sharp"
                                    tileColor: "#7030a0"
                                    onClicked: compositor.resetAmoledTimer()
                                }
                                Tile {
                                    id: tile12
                                    width: tileGrid.tileWidth; height: tileGrid.tileHeight
                                    tileColumn: 1; tileRow: 5
                                    pageVisible: !compositor.shadeVisible && !compositor.appLaunchActive && !compositor.backgroundAppsVisible
                                    title: "Podcasts"; subtitle: "New episode"; icon: "cloud-sharp"
                                    tileColor: "#006b5b"
                                     onClicked: compositor.resetAmoledTimer()
                                 }
                                 }
                             }
                        }

                        Connections {
                            target: homeFlick
                            function onContentYChanged() { tileGrid.updateTileVisibility() }
                            function onHeightChanged() { Qt.callLater(tileGrid.updateTileVisibility) }
                            function onWidthChanged() { Qt.callLater(tileGrid.updateTileVisibility) }
                        }

                        Item {
                            width: parent.width
                            height: 100
                            visible: compositor.amoledHintActive
                            opacity: visible ? 1 : 0

                            Behavior on opacity { NumberAnimation { duration: 250 } }

                            Column {
                                anchors.centerIn: parent
                                spacing: 4

                                SvgIcon {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    name: "arrow-down-sharp"
                                    width: 28
                                    height: 28
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "swipe down for quick settings"
                                    color: Theme.secondaryText
                                    font.pixelSize: 13
                                }
                            }
                        }
                    }
                }

                DragHandler {
                    id: homeSwipeLeft
                    target: null
                    enabled: !backgroundAppsPanel.visible
                    xAxis.enabled: true
                    yAxis.enabled: false

                    onActiveChanged: {
                        if (active) {
                            appsPanel.beginHomeDrag()
                        } else if (appsPanel.dragging) {
                            if (appsPanel.dragX < -70) {
                                compositor.openApps()
                                appsPanel.finishHomeDrag(true)
                            } else {
                                appsPanel.finishHomeDrag(false)
                            }
                        }
                    }

                    onTranslationChanged: {
                        if (active)
                            appsPanel.updateHomeDrag(translation.x)
                    }
                }
            }

            // ==================================================
            // APPS — fullscreen panel from the right
            // ==================================================

            AppsPanel {
                id: appsPanel

                anchors.fill: parent
                z: 150

                appsVisible: compositor.appsVisible
                shadeVisible: compositor.shadeVisible
                shellStatusBarHeight: shellStatusBar.height
                wallpaperUrl: shellConfig.wallpaperUrl
                 backdropSource: backdropScene
                 backdropRect: Qt.rect(0, 0, mainWindow.width, mainWindow.height)
                wallpaperDim: shellConfig.wallpaperDim
                wallpaperBlur: shellConfig.tileBlur

                onCloseApps: compositor.closeApps()
                onLaunchApp: (name) => compositor.launchApp(name)
            }

            // ==================================================
            // NOTIFICATION SHADE
            // ==================================================

            Item {
                id: shade

                anchors.fill: parent
                z: 200

                visible: compositor.shadeVisible || shade.closing
                property bool closing: false

                Rectangle {
                    anchors.fill: parent
                    color: "#000000"
                    opacity: compositor.shadeVisible ? 0.12 : 0
                    Behavior on opacity { NumberAnimation { duration: 280 } }
                }

                Rectangle {
                    id: shadePanel

                    width: parent.width
                    height: parent.height - Theme.navBarHeight

                    y: shadePanel.slideY
                    property real slideY: compositor.shadeVisible ? 0 : -height

                    Behavior on slideY {
                        NumberAnimation { duration: 360; easing.type: Easing.OutCubic }
                    }

                    color: "transparent"

                    GlassBackdrop {
                        anchors.fill: parent
                        z: -1
                        wallpaperDim: shellConfig.wallpaperDim
                        blurAmount: shellConfig.tileBlur
                        tintColor: Theme.shadeBackground
                        tintOpacity: 0.72
                         sourceItem: backdropScene
                         sourceRect: Qt.rect(0, 0, mainWindow.width,
                                             mainWindow.height)
                         blurProgress: Math.max(0, Math.min(1,
                             1 - Math.abs(shadePanel.slideY)
                             / Math.max(1, shadePanel.height)))
                    }

                    TouchFlickable {
                        id: shadeFlick
                        anchors.fill: parent
                        contentWidth: width
                        contentHeight: shadeContent.height

                        Column {
                            id: shadeContent
                            width: shadePanel.width
                            spacing: 0

                            Rectangle {
                                width: parent.width
                                height: 150
                                color: Theme.shadeBackgroundTop

                                Column {
                                    anchors {
                                        left: parent.left
                                        top: parent.top
                                        leftMargin: mainWindow.pageMargin
                                        topMargin: 32
                                    }
                                    spacing: 4

                                    Text {
                                        text: compositor.currentTime
                                        color: Theme.text
                                        font.pixelSize: 46
                                        font.weight: Font.Light
                                    }
                                    Text {
                                        text: compositor.currentDate
                                        color: Theme.secondaryText
                                        font.pixelSize: 15
                                    }
                                }

                                Rectangle {
                                    anchors {
                                        right: parent.right
                                        top: parent.top
                                        rightMargin: mainWindow.pageMargin
                                        topMargin: 22
                                    }
                                    width: 48; height: 48
                                    color: settingsMouse.pressed ? Theme.shadeSurfaceHover : Theme.shadeSurface
                                    scale: settingsMouse.pressed ? 0.92 : 1

                                    Behavior on scale { NumberAnimation { duration: 100 } }

                                    SvgIcon { anchors.centerIn: parent; name: "settings-sharp"; width: 22; height: 22 }
                                    MouseArea { id: settingsMouse; anchors.fill: parent }
                                }

                                Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: Theme.divider }
                            }

                            Item { width: 1; height: 18 }

                            Grid {
                                id: quickGrid
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width - mainWindow.pageMargin * 2
                                columns: mainWindow.phoneMode ? 2 : 4
                                spacing: 8

                                property real buttonWidth: columns === 2 ? (width - 8) / 2 : (width - 24) / 4

                                QuickToggle {
                                    width: quickGrid.buttonWidth; height: 86
                                    iconName: "wifi-sharp"; title: "Wi-Fi"
                                    subtitle: compositor.wifiEnabled ? "Connected" : "Off"
                                    active: compositor.wifiEnabled
                                    onClicked: compositor.wifiEnabled = !compositor.wifiEnabled
                                }
                                QuickToggle {
                                    width: quickGrid.buttonWidth; height: 86
                                    iconName: "bluetooth-sharp"; title: "Bluetooth"
                                    subtitle: compositor.bluetoothEnabled ? "On" : "Off"
                                    active: compositor.bluetoothEnabled
                                    onClicked: compositor.bluetoothEnabled = !compositor.bluetoothEnabled
                                }
                                QuickToggle {
                                    width: quickGrid.buttonWidth; height: 86
                                    iconName: "cellular-sharp"; title: "Mobile"
                                    subtitle: compositor.cellularEnabled ? "5G" : "Off"
                                    active: compositor.cellularEnabled
                                    onClicked: compositor.cellularEnabled = !compositor.cellularEnabled
                                }
                                QuickToggle {
                                    width: quickGrid.buttonWidth; height: 86
                                    iconName: compositor.silentMode ? "volume-off-sharp" : "volume-high-sharp"
                                    title: "Sound"
                                    subtitle: compositor.silentMode ? "Silent" : "Ring"
                                    active: compositor.silentMode
                                    onClicked: compositor.silentMode = !compositor.silentMode
                                }
                            }

                            Item { width: 1; height: 20 }

                            Rectangle {
                                width: parent.width - mainWindow.pageMargin * 2
                                height: 54
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: Theme.shadeSurface

                                Row {
                                    anchors { fill: parent; margins: 14 }
                                    spacing: 14

                                    SvgIcon { name: "brightness"; width: 22; height: 22; anchors.verticalCenter: parent.verticalCenter }
                                    BrightnessSlider { width: parent.width - 44; anchors.verticalCenter: parent.verticalCenter }
                                }
                            }

                            Item { width: 1; height: 22 }

                            Item {
                                width: parent.width; height: 64

                                Text {
                                    anchors { left: parent.left; bottom: parent.bottom; leftMargin: mainWindow.pageMargin; bottomMargin: 10 }
                                    text: "notifications"
                                    color: Theme.text; font.pixelSize: 28; font.weight: Font.Light
                                }

                                Text {
                                    anchors { right: parent.right; bottom: parent.bottom; rightMargin: mainWindow.pageMargin; bottomMargin: 12 }
                                    text: compositor.unreadNotifications + " new"
                                    color: Theme.secondaryText; font.pixelSize: 13
                                }
                            }

                            NotificationCard {
                                width: parent.width - mainWindow.pageMargin * 2
                                anchors.horizontalCenter: parent.horizontalCenter
                                iconName: "chatbubble-sharp"; title: "Messages"
                                subtitle: "You have 3 new messages"; accentColor: "#107c10"
                            }

                            Item { width: 1; height: 6 }

                            NotificationCard {
                                width: parent.width - mainWindow.pageMargin * 2
                                anchors.horizontalCenter: parent.horizontalCenter
                                iconName: "musical-notes-sharp"; title: "Music"
                                subtitle: "Now playing — Unknown Artist"; accentColor: "#d83b01"
                            }

                            Item {
                                width: parent.width
                                height: Math.max(80, shadeFlick.height - y - 48)

                                MouseArea { anchors.fill: parent; onClicked: compositor.closeShade() }
                            }
                        }
                    }
                }

                Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: Theme.navBarHeight + 14
                    }
                    z: 2
                    transform: Translate { y: shadePanel.slideY }
                    text: compositor.operatorName
                    color: Theme.secondaryText
                    font.pixelSize: 14
                }

                Connections {
                    target: compositor
                    function onShadeVisibleChanged() {
                        if (!compositor.shadeVisible) {
                            shade.closing = true
                            shadeCloseTimer.start()
                        } else {
                            shade.closing = false
                        }
                    }
                }

                Timer { id: shadeCloseTimer; interval: 360; onTriggered: shade.closing = false }

                DragHandler {
                    target: null
                    xAxis.enabled: false
                    yAxis.enabled: true
                    onTranslationChanged: {
                        if (active && translation.y < -70)
                            compositor.closeShade()
                    }
                }
            }

            // ==================================================
            // BACKGROUND APPS
            // ==================================================

            BackgroundAppsPanel {
                id: backgroundAppsPanel

                backgroundAppsVisible: compositor.backgroundAppsVisible
                shellStatusBarHeight: shellStatusBar.height
                navBarHeight: navBar.height
                pageMargin: mainWindow.pageMargin
                surfaceAspectRatio: mainWindow.width / Math.max(1, mainWindow.height)
                wallpaperUrl: shellConfig.wallpaperUrl
                 backdropSource: backdropScene
                 backdropRect: Qt.rect(0, 0, mainWindow.width, mainWindow.height)
                wallpaperDim: shellConfig.wallpaperDim
                wallpaperBlur: shellConfig.tileBlur

                surfaceModel: compositor.shellSurfaces
                focusedIndex: compositor.focusedIndex

                onSurfaceFocused: (index) => {
                    compositor.focusApp(index)
                    compositor.closeBackgroundApps()
                }
                onSurfaceClosed: (index) => compositor.closeApp(index)
            }

            FolderView {
                id: folderView

                folderVisible: compositor.folderVisible
                folderProgress: compositor.folderProgress
                folderTitle: compositor.folderTitle
                appIndexes: compositor.folderAppIndexes
                appModel: desktopApps
                wallpaperUrl: shellConfig.wallpaperUrl
                wallpaperDim: shellConfig.wallpaperDim
                wallpaperBlur: shellConfig.tileBlur

                onCloseRequested: compositor.closeFolder()
            }

            // ==================================================
            // TOUCH NAVBAR
            // ==================================================

            TouchNavBar {
                id: navBar

                z: 300

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                homeActive: mainWindow.homeActive
                backgroundActive: compositor.backgroundAppsVisible

                backEnabled:
                    compositor.appsVisible ||
                    compositor.shadeVisible ||
                    compositor.backgroundAppsVisible ||
                    compositor.folderVisible ||
                    compositor.hasFocusedApp

                backgroundOpacity: hasFocusedApp ? 1 : compositor.backgroundAppsVisible ? 0 : 0.8
                onNavigateHome: compositor.goHome()
                onNavigateBackground: compositor.openBackgroundApps()
                onNavigateBack: {
                    if (compositor.backgroundAppsVisible)
                        compositor.closeBackgroundApps()
                    else if (compositor.folderVisible)
                        compositor.closeFolder()
                    else if (compositor.shadeVisible)
                        compositor.closeShade()
                    else if (compositor.appsVisible)
                        compositor.closeApps()
                    else if (compositor.hasFocusedApp)
                        compositor.goHome()
                }
            }

            // ==================================================
            // KEYBOARD
            // ==================================================

            Shortcut {
                sequence: "Escape"
                onActivated: {
                    if (compositor.shadeVisible)
                        compositor.closeShade()
                    else if (compositor.folderVisible)
                        compositor.closeFolder()
                    else if (compositor.appsVisible)
                        compositor.goHome()
                }
            }

            Shortcut {
                sequence: "Ctrl+Shift+S"
                onActivated: {
                    if (compositor.shadeVisible)
                        compositor.closeShade()
                    else
                        compositor.openShade()
                }
            }
        }
    }
}
