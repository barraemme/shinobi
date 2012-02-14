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

Image {
    id: indicator
    property int count: 0
    property real value: 1.0

    source: "image://cached/fuel_bg.png"

    Item {
        z: -1
        clip: true
        width: parent.width * indicator.value
        height: parent.height

        Image {
            source: indicator.count > 0 ? "image://cached/fuel_fg_plus.png"
                : "image://cached/fuel_fg.png"
        }
    }
}
