import QtQuick

Flickable {
    id: root

    property int overrideBottomMargin: 0

    interactive: true
    clip: true

    boundsBehavior: Flickable.StopAtBounds
    boundsMovement: Flickable.StopAtBounds

    flickDeceleration: 2200
    maximumFlickVelocity: 4000
    pressDelay: 0

    bottomMargin: overrideBottomMargin

    WheelHandler {
        onWheel: (event) => {
            var delta = event.angleDelta.y / 8

            root.contentY = Math.max(
                0,
                Math.min(
                    root.contentHeight - root.height,
                    root.contentY - delta
                )
            )

            event.accepted = true
        }
    }
}
