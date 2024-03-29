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

Item {
    id: root
    signal backClicked()

    property int offset: 0

    Item {
        x: -root.offset

        AboutFlag {
            x: 180
            y: 156
        }

        Image {
            x: 600
            y: 310
            source: "image://cached/menu/back.png"

            MouseArea {
                anchors.fill: parent
                onClicked: root.backClicked()
            }
        }
    }
}
