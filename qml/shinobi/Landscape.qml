import QtQuick 1.1

Item {
    id: root
    property int offset: 0
    property int displacement: 0
    property int pixelLoop: root.width * 15

    Image {
        x: -0.2 * (root.offset + displacement)
        width: root.width * 30
        anchors.bottom: parent.bottom
        fillMode: Image.TileHorizontally
        source: "image://cached/scene/mountain.png"
    }

    Image {
        x: -1.0 * (root.offset + displacement)
        width: root.width * 30
        anchors.bottom: parent.bottom
        fillMode: Image.TileHorizontally
        source: "image://cached/scene/ground.png"
    }
}
