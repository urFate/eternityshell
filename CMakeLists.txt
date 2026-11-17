cmake_minimum_required(VERSION 3.16)

project(eternityshell VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick WaylandCompositor)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appeternityshell
    main.cpp
    desktopappmodel.cpp
    desktopappmodel.h
    shellconfig.cpp
    shellconfig.h
)

set_source_files_properties(theme/Theme.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appeternityshell
    URI eternityshell
    QML_FILES
        Main.qml
        theme/Theme.qml
        components/Tile.qml
        components/QuickToggle.qml
        components/SvgIcon.qml
        components/StatusBar.qml
        components/NavButton.qml
        components/TouchNavBar.qml
        components/TouchFlickable.qml
        components/NotificationCard.qml
        components/BrightnessSlider.qml
        components/AppsList.qml
        components/AppsPanel.qml
        components/BackgroundAppsPanel.qml
        components/FolderTile.qml
        components/FolderView.qml
        components/GlassBackdrop.qml
        components/icons/apps-sharp.qml
        components/icons/arrow-back-sharp.qml
        components/icons/arrow-down-sharp.qml
        components/icons/battery-full-sharp.qml
        components/icons/bluetooth-sharp.qml
        components/icons/brightness.qml
        components/icons/calendar-sharp.qml
        components/icons/camera-sharp.qml
        components/icons/cellular-sharp.qml
        components/icons/chatbubble-sharp.qml
        components/icons/cloud-sharp.qml
        components/icons/document-sharp.qml
        components/icons/folder-sharp.qml
        components/icons/globe-sharp.qml
        components/icons/grid-sharp.qml
        components/icons/home-sharp.qml
        components/icons/images-sharp.qml
        components/icons/mail-sharp.qml
        components/icons/mic-sharp.qml
        components/icons/musical-notes-sharp.qml
        components/icons/navigate-sharp.qml
        components/icons/search-sharp.qml
        components/icons/settings-sharp.qml
        components/icons/sound.qml
        components/icons/sound-off.qml
        components/icons/sunny-sharp.qml
        components/icons/terminal-sharp.qml
        components/icons/tv-sharp.qml
        components/icons/volume-high-sharp.qml
        components/icons/volume-off-sharp.qml
        components/icons/wifi-sharp.qml
    RESOURCES
        font/Ubuntu-Regular.ttf
        font/Ubuntu-Light.ttf
        font/Ubuntu-Medium.ttf
        font/Ubuntu-Bold.ttf
        font/Ubuntu-Italic.ttf
        font/Ubuntu-LightItalic.ttf
        font/Ubuntu-MediumItalic.ttf
        font/Ubuntu-BoldItalic.ttf
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appeternityshell PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appeternityshell
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appeternityshell
    PRIVATE Qt6::Quick Qt6::WaylandCompositor
)
include(GNUInstallDirs)
install(TARGETS appeternityshell
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
