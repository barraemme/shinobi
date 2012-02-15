import QtQuick 1.1

Item {
    id: root
    property int offset: 0
    property int displacement: 0
    property int pixelLoop: root.width * 15
    property string front: "image://cached/scene/ground.png"
    property string back: "image://cached/scene/trees.png"

    Image {
        x: -0.2 * (root.offset + displacement)
        width: root.width * 30
        anchors.bottom: parent.bottom
        fillMode: Image.TileHorizontally
        source: root.back
        z:5
    }

    Image {
        x: -1.0 * (root.offset + displacement)
        width: root.width * 30
        anchors.bottom: parent.bottom
        fillMode: Image.TileHorizontally
        source: root.front
        z:6
    }
}
