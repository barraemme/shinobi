import QtQuick 1.1

Item {
    id: splash
    signal timeout()

    Image {
        anchors.centerIn: parent
        source: "image://cached/scene/bg-night.png"

    }

    MouseArea {
        // block mouse events
        anchors.fill: parent
    }

    Landscape {
        anchors.fill: parent

        back: "image://cached/scene/ground-night.png"
        front: "image://cached/scene/home-night.png"

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            y: ninja.maxHeight-100
            text: "Loading ..."
            font.pointSize: 50
            color: "#10522F"
            z:50
        }

        Image {
            x: 390
            y: ninja.minHeight+ninja.height+20
            source: "image://cached/loading/shadow.png"
            // The scale property depends on the y position
            scale: ninja.y * 0.2 / (ninja.minHeight - ninja.maxHeight)
        }


        Image {
            id: ninja
            property int maxHeight: 220
            property int minHeight: 260
            x: 368
            y: minHeight
            width: 89
            height: 107
            source: "image://cached/loading/1.png"

            SequentialAnimation on y {
                loops: Animation.Infinite
                running: true

                // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
                NumberAnimation {
                    from: ninja.minHeight; to: ninja.maxHeight
                    duration: 3000
                }

                // Then move back to minHeight in 1 second, using the OutBounce easing function
                NumberAnimation {
                    from: ninja.maxHeight; to: ninja.minHeight
                    duration: 3000
                }

            }
        }
    }

    Timer {
        running: true
        interval: 1500
        onTriggered: splash.timeout();
    }
}
