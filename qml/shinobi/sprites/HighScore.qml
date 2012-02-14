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
import Expresso 1.0

Image {
    source: "image://cached/sprites/wood.png"

    Sprite {
        x: -150
        width: 160
        height: 67

        spriteStates: SpriteState {
            frameCount: 6
            frameRate: 0.3
            frameWidth: 160
            frameHeight: 67

            sources: [
                "image://cached/highscore/1.png",
                "image://cached/highscore/2.png",
                "image://cached/highscore/3.png",
                "image://cached/highscore/4.png",
                "image://cached/highscore/5.png",
                "image://cached/highscore/6.png"
            ]
        }
    }
}
