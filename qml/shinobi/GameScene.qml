/****************************************************************************
**
** Copyright (C) 2011 Nokia Institute of Technology.
** All rights reserved.
** Contact: Manager (renato.chencarek@openbossa.org)
**
** This file is part of the PathWind project.
**
** GNU Lesser General Public License Usage
**
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
****************************************************************************/

import QtQuick 1.1
import Box2D 1.0
import Expresso 1.0
import "sprites"
import "engine.js" as Engine

Item {
    id: root

    property int displacement: 0
    property alias fuel: player.fuel
    property alias fuelPlus: player.fuelPlus
    property alias running: world.running
    property alias highScoreFlagPos: highScoreFlag.x
    property alias verticalDisplacement: canvas.sceneY

    function init() {
        Engine.init();
        Engine.startGame(false);
    }

    function restart() {
        Engine.restartGame();
    }

    SpriteScene {
        id: canvas
        x: root.displacement
        width: root.width
        height: root.height

        automaticStep: false
        //move background
        //onAdvanced: Engine.tick();

        property real sceneX: 0
        property real sceneY: Math.min(0.0, player.y)
        property real sceneWidth: canvas.width *6.0
        property real sceneHeight: canvas.height * 6.0

        World {
            id: world
            x: canvas.sceneX
            y: -canvas.sceneY
            width: parent.width
            height: parent.height
            running: root.running
            gravity: Qt.point(0, -20)

            HowToFlag {
                x: parent.width * 0.4
                showSmallBird: false
                anchors.verticalCenter: parent.verticalCenter
            }

            Player {
                id: player
                z: 1
            }

            Shuriken {
                id: bullet
                z: 2
                x: player.x+100
                y: player.y
            }

            Floor {
                id: floor
                y: canvas.height - height
                width: canvas.sceneWidth
            }

            Ceil {
                y: -canvas.height - height
                width: canvas.sceneWidth
            }

            HighScore {
                id: highScoreFlag
                y: 300
            }
        }        

        MouseArea {
            id: fis
            anchors.fill: parent

            /* Get first positions */
            property int oldX
            property int oldY

            /* Calculate new positions */
            property int newX
            property int newY

            onPressed: {
                fis.oldX = mouse.x
                fis.oldY = mouse.y
                log();
            }

            /*onPositionChanged: {
                fis.newX = mouse.x
                fis.newY = mouse.y
                log();
            }*/

            onReleased: {
                fis.newX = mouse.x
                fis.newY = mouse.y
                log();

                Engine.playerLoadBullet(Qt.point(fis.newX-fis.oldX, fis.newY-fis.oldY));
            }

            function log(){
                console.log("old X:"+oldX);
                console.log("old Y:"+oldY);
                console.log("new X:"+newX);
                console.log("new Y:"+newY);
            }

        }

        Component.onCompleted: {
            world.stepped.connect(canvas.tick);
        }
    }
}
