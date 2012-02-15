import QtQuick 1.1

Item {
    id: splash
    signal timeout()

    MouseArea {
        // block mouse events
        anchors.fill: parent
    }

    Landscape {
        anchors.fill: parent

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            y: 150
            text: "Loading ..."
            font.pointSize: 50
            color: "black"
            style: Text.Outline;
            styleColor: "#10522F"
        }

        Image {
            x: 390
            y: 450
            source: "image://cached/loading/shadow.png"
            // The scale property depends on the y position
            scale: ninja.y * 0.2 / (ninja.minHeight - ninja.maxHeight)
        }


        Image {
            id: ninja
            property int maxHeight: 300
            property int minHeight: 340
            x: 368
            y: minHeight
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
