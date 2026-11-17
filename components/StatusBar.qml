import QtQuick
import QtQuick.Effects
import eternityshell.theme

Item {
    id: root

    property string time: ""
    property int batteryLevel: 100
    property bool wifiEnabled: true
    property bool cellularEnabled: true
    property int cellularStrength: 4
    property bool silentMode: false
    property bool inverted: false
    property bool transparent: false

    property int horizontalMargin: 12

    readonly property color glyphColor:
        inverted ? "#ffffff" : Theme.text

    implicitHeight: 32
    height: implicitHeight

    property Item sourceItem

    readonly property bool isDarkArea: lumaResult < 0.5
    property real lumaResult: 1.0 // По умолчанию светлый фон (черный текст)

    Rectangle {
        anchors.fill: parent
        visible: !root.transparent
        clip: true

        MultiEffect {
            anchors.fill: parent
            blurEnabled: true
            blur: 1.0
            saturation: 0.2

            // Захватываем только ту часть фона, которая находится под статус-баром
            source: ShaderEffectSource {
                id: topRegionSampler
                sourceItem: root.sourceItem
                // Передаем координаты и размеры статус-бара относительно фона
                sourceRect: Qt.rect(0, 0, root.sourceItem ? root.sourceItem.width : 0, 32)
                live: true // Перерисовывать, если фон под статус-баром меняется
            }
        }

        Timer {
           id: analysisTimer
           interval: 300 // Проверяем 3 раза в секунду
           running: root.sourceItem !== null
           repeat: true

           onTriggered: {
               if (!root.sourceItem) return;
               var sampler = topRegionSampler;
               if (!sampler || !root.activeWindowItem) return;

               // Запрашиваем пиксели только у вырезанной полоски
               topRegionSampler.grabToImage(function(result) {
                   // Для экономии ресурсов берем всего 3 точки: слева, по центру и справа
                   var img = result.image;
                   var w = img.width;

                   var colorLeft = img.pixelColor(w * 0.2, 16);
                   var colorCenter = img.pixelColor(w * 0.5, 16);
                   var colorRight = img.pixelColor(w * 0.8, 16);

                   // Считаем среднюю яркость (luminance) по трем точкам
                   var avgR = (colorLeft.r + colorCenter.r + colorRight.r) / 3;
                   var avgG = (colorLeft.g + colorCenter.g + colorRight.g) / 3;
                   var avgB = (colorLeft.b + colorCenter.b + colorRight.b) / 3;

                   // Стандартная sRGB формула яркости
                   root.lumaResult = 0.2126 * avgR + 0.7152 * avgG + 0.0722 * avgB;

                   console.log("Средняя яркость области:", root.lumaResult);
               }, Qt.size(sampler.width, 32)); // Ограничиваем размер рендера
           }
        }

        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.3
        }
    }


    Row {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter

            leftMargin: root.horizontalMargin
        }

        spacing: 10

        SvgIcon {
            name: "cellular-sharp"
            width: 18
            height: 18
            color: root.glyphColor
            dimmed: !root.cellularEnabled
            anchors.verticalCenter: parent.verticalCenter
        }

        SvgIcon {
            name: "wifi-sharp"
            width: 18
            height: 18
            color: root.glyphColor
            dimmed: !root.wifiEnabled
            anchors.verticalCenter: parent.verticalCenter
        }

        SvgIcon {
            name: root.silentMode ? "volume-off-sharp" : "volume-high-sharp"
            width: 17
            height: 17
            color: root.glyphColor
            dimmed: !root.silentMode
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Row {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter

            rightMargin: root.horizontalMargin
        }

        spacing: 8

        SvgIcon {
            name: "battery-full-sharp"
            width: 22
            height: 24
            color: root.glyphColor
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.time

            color: root.glyphColor

            font.pixelSize: 16
            font.weight: Font.Light

            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
