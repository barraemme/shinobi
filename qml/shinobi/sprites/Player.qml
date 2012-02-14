// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Box2D 1.0
import Expresso 1.0

FrameSprite {
    id: player

    property real fuel: 1.0
    property int fuelPlus: 0
    property bool alive: true

    width: 120
    height: 132
    bullet: true
    fixedRotation: true
    sleepingAllowed: false

    fixtures: [
        Box {
            x: 28
            y: 14
            width: 66
            height: 55
            density: 1
            friction: 1
            categories: Box.Category4
            onBeginContact: handleCollision(other);
        },
        Box {
            x: 22
            y: 60
            width: 35
            height: 65
            density: 1
            friction: 1
            categories: Box.Category4
            onBeginContact: handleCollision(other);
        }
    ]

    spriteStates: [
        SpriteState {
            id: fallingState
            frameCount: 3
            frameRate: 0.32
            frameWidth: 120
            frameHeight: 132
            sources: [
                "image://cached/sprites/player/falling/1.png",
                "image://cached/sprites/player/falling/2.png",
                "image://cached/sprites/player/falling/3.png",
            ]
        },
        SpriteState {
            id: walkingState
            frameCount: 6
            frameRate: 0.34
            frameWidth: 120
            frameHeight: 132
            sources: [
                "image://cached/sprites/player/walking/1.png",
                "image://cached/sprites/player/walking/2.png",
                "image://cached/sprites/player/walking/3.png",
                "image://cached/sprites/player/walking/4.png",
                "image://cached/sprites/player/walking/5.png",
                "image://cached/sprites/player/walking/6.png",
            ]
        },
        SpriteState {
            id: flyingState
            frameCount: 3
            frameRate: 0.32
            frameWidth: 120
            frameHeight: 132
            sources: [
                "image://cached/sprites/player/flying/1.png",
                "image://cached/sprites/player/flying/2.png",
                "image://cached/sprites/player/flying/3.png",
            ]
            onActivated: jetSound.play();
            onDeactivated: jetSound.stop();
        },
        SpriteState {
            id: jumpToFlyState
            frameCount: 2
            frameRate: 0.22
            frameWidth: 120
            frameHeight: 132
            loopCount: 1
            nextState: flyingState
            sources: [
                "image://cached/sprites/player/jumping/1.png",
                "image://cached/sprites/player/jumping/2.png",
            ]
        }
    ]

    PcmSound {
        id: hitSound
        muted: screen.muted
        source: Qt.resolvedUrl("../sounds/hit.wav")
    }

    PcmSound {
        id: gasSound
        muted: screen.muted
        source: Qt.resolvedUrl("../sounds/gas.wav")
    }

    PcmSound {
        id: jetSound
        muted: screen.muted
        paused: !world.running
        loops: PcmSound.Infinite
        source: Qt.resolvedUrl("../sounds/jet.wav")
    }

    function reset() {
        player.x = 100;
        player.y = -height;
        player.fuel = 1.0;
        player.fuelPlus = 0;
        player.alive = true;
        player.linearVelocity.x = 0;
        player.linearVelocity.y = 0;
        player.spriteState = fallingState;
    }

    function advance() {
        if (player.alive)
            player.linearVelocity.x = 300;

        if (player.spriteState == flyingState) {
            var impulse = Qt.point(0, -240);
            player.fuel = Math.max(0, player.fuel - 0.044);

            if (player.fuel <= 0) {
                if (player.fuelPlus == 0) {
                    player.stop();
                } else {
                    player.fuelPlus--;
                    player.fuel = 1.0;
                }
            } else {
                player.applyLinearImpulse(impulse, getWorldCenter());
            }
        } else {
            player.fuel = Math.min(1.0, player.fuel + 0.010);
        }

        var impulse = Qt.point(-300, 0);
        player.applyLinearImpulse(impulse, getWorldCenter());
    }

    function handleCollision(other) {
        // ceil collision
        if (other.categories == Box.Category6)
            return;

        // ground collision
        if (other.categories == Box.Category2) {
            sprite.spriteState = walkingState;
            return;
        }

        // bonus collision
        if (other.categories == Box.Category3) {
            if (player.fuelPlus == 0)
                player.fuelPlus++;
            gasSound.play();
            return;
        }

        // enemy collision
        if (player.alive) {
            player.alive = false;
            hitSound.play();
        }
    }

    function fly() {
        if (player.fuel <= 0)
            return;

        if (player.spriteState == walkingState)
            player.spriteState = jumpToFlyState;
        else
            player.spriteState = flyingState;
    }

    function stop() {
        if (player.spriteState == flyingState)
            player.spriteState = fallingState;
        else if (player.spriteState == jumpToFlyState)
            player.spriteState = walkingState;
    }
}
