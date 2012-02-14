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
    id: sprite

    width: 90
    height: 77
    xVelocity: -1
    yVelocity: -1
    fixedRotation: true

    fixtures: Box {
        width: 36
        height: 36
        density: 0.8
        friction: 0.2
        restitution: 0.8
        categories: Box.Category3
        collidesWith: Box.Category4
        onBeginContact: sprite.destroy(1);
    }

    spriteStates: SpriteState {
        frameCount: 4
        frameRate: 0.3
        frameWidth: 36
        frameHeight: 36

        sources: [
            "image://cached/fuelcell/1.png",
            "image://cached/fuelcell/2.png",
            "image://cached/fuelcell/3.png",
            "image://cached/fuelcell/4.png",
        ]
    }
}
