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

PixmapText {
    source: "image://cached/digits.png"

    charMap: {
        '0': Qt.rect(1, 0, 21, 27),
        '1': Qt.rect(25, 0, 13, 27),
        '2': Qt.rect(42, 0, 20, 27),
        '3': Qt.rect(65, 0, 23, 27),
        '4': Qt.rect(91, 0, 23, 27),
        '5': Qt.rect(117, 0, 23, 27),
        '6': Qt.rect(143, 0, 23, 27),
        '7': Qt.rect(168, 0, 21, 27),
        '8': Qt.rect(192, 0, 21, 27),
        '9': Qt.rect(219, 0, 21, 27),
    }
}
