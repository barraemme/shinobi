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
import ".."

FrameSprite {
    width: 90
    height: 77
    xVelocity: -200
    yVelocity: 50
    fixedRotation: true

    fixtures: Box {
        width: 90
        height: 77
        density: 0.8
        friction: 0.2
        restitution: 0.8
    }

    spriteStates: SpriteState {
        frameCount: 6
        frameRate: 0.4
        frameWidth: 90
        frameHeight: 77

        sources: [
            "image://cached/birds/big/1.png",
            "image://cached/birds/big/2.png",
            "image://cached/birds/big/3.png",
            "image://cached/birds/big/4.png",
            "image://cached/birds/big/5.png",
            "image://cached/birds/big/6.png",
        ]
    }
}
