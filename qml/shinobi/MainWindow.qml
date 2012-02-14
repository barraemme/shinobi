import QtQuick 1.1
import Expresso 1.0

Item {
    property int unlockCount: 0

    Image {
        anchors.centerIn: parent
        source: "image://cached/scene/bg.png"

        Loader {
            id: screen
            anchors.fill: parent
        }

        Loader {
            id: splash
            anchors.fill: parent
            source: Qt.resolvedUrl("Splash.qml")
        }

    }

    ImageLoader {
        prefix: "cached"
        folder: Qt.resolvedUrl("images")
        onStatusChanged: {
            if (status == ImageLoader.Loaded)
                unlock();
        }
    }

    Connections {
        target: splash.item
        onTimeout: unlock();
    }

    function unlock() {
        unlockCount++;

        if (unlockCount == 2) {
            splash.source = "";
            screen.source = Qt.resolvedUrl("Screen.qml");
            screen.item.start();
        }
    }
}
