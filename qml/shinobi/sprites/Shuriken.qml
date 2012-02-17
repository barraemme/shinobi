import QtQuick 1.1
import Box2D 1.0
import Expresso 1.0
import ".."

ImageSprite {
    width: 25
    height: 24

    source: "image://cached/sprites/bullets/shuriken/1.png"

    xVelocity: 0
    yVelocity: 0
    fixedRotation: false

    fixtures: Box {
        width: 25
        height: 24
        density: 0.5
        friction: 1
        restitution: 0
    }

}
