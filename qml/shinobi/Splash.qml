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

        Image {
            x: 368
            y: 156
            property int index: 1
            source: "image://cached/loading/" + index + ".png"

            NumberAnimation on index {
                from: 1
                to: 4
                duration: 250
                running: true
                loops: Animation.Infinite
            }
        }
    }

    Timer {
        running: true
        interval: 1500
        onTriggered: splash.timeout();
    }
}
