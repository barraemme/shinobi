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
        onAdvanced: Engine.tick();

        property real sceneX: 0
        property real sceneY: Math.min(0.0, player.y)
        property real sceneWidth: 10e8
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

            Floor {
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
            anchors.fill: parent
            onPressed: player.fly();
            onReleased: player.stop();
        }

        Component.onCompleted: {
            world.stepped.connect(canvas.tick);
        }
    }
}
