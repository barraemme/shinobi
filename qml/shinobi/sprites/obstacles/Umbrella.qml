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
import ".."

ImageSprite {
    source: "image://cached/sprites/obstacles/umbrella.png"

    fixtures: [
        Polygon {
            x: 28
            y: 28
            friction: 0.1
            density: 0.2
            restitution: 1.0
            vertices: [
                Qt.point(58, 11),
                Qt.point(4, 44),
                Qt.point(109, 37),
            ]
        },
        Box {
            x: 56
            y: 1
            width: 6
            height: 104
            friction: 0.1
            density: 0.2
            restitution: 1.0
        }
    ]
}
