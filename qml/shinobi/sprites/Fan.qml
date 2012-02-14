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

FrameSprite {
    id: root

    width: 305
    height: 447
    fixedRotation: true
    bodyType: Body.Static

    property bool running: true

    spriteStates: SpriteState {
        frameCount: 7
        frameWidth: root.width
        frameHeight: root.height
        frameRate: running ? 1.0 : 0.0

        sources: [
            "image://cached/sprites/obstacles/fan/1.png",
            "image://cached/sprites/obstacles/fan/2.png",
            "image://cached/sprites/obstacles/fan/3.png",
            "image://cached/sprites/obstacles/fan/4.png",
            "image://cached/sprites/obstacles/fan/5.png",
            "image://cached/sprites/obstacles/fan/6.png",
            "image://cached/sprites/obstacles/fan/7.png",
        ]
    }
}
