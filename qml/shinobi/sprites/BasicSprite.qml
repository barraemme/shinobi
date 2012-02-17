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

Body {
    id: sprite
    bodyType: Body.Dynamic

    property int xVelocity: 0
    property int yVelocity: 0

    property alias sprite: coreSprite
    property alias spriteState: coreSprite.spriteState
    property alias spriteStates: coreSprite.spriteStates

    Sprite {
        id: coreSprite
        onAdvanced: advance();
    }

    function advance() {
        if (xVelocity != 0)
            sprite.linearVelocity.x = xVelocity;

        if (yVelocity != 0)
            sprite.linearVelocity.y = yVelocity;

        if ((sprite.x + sprite.width * 2 < -canvas.sceneX) || (sprite.x + sprite.width * 2 > canvas.sceneWidth))
            sprite.destroy(0);
    }
}
