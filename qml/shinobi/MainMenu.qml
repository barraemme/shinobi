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

    signal playClicked()
    signal replayClicked()
    signal aboutClicked()

    property int displacement: 0
    property bool replayEnabled: false
    property bool running: root.visible && Qt.application.active

    Item {
        x: root.displacement
        width: parent.width
        height: parent.height

        Image {
            x: 200
            y: 60
            source: "image://cached/menu/big_sign.png"

            Score {
                x: 224
                y: 62
                rotation: -12
                value: screen.highScore
                transformOrigin: Item.TopLeft
            }

            LoopImage {
                x: 112
                y: 8
                z: -1
                frameCount: 6
                duration: 350
                running: root.running
                path: "image://cached/highscore"
            }

            LoopImage {
                x: 318
                y: 84
                frameCount: 4
                duration: 250
                running: root.running
                path: "image://cached/menu/fan"
            }
        }

        Image {
            x: 630
            y: 228
            source: "image://cached/menu/play.png"

            MouseArea {
                x: 20
                y: 30
                width: 140
                height: 70
                rotation: 10
                onClicked: root.playClicked();
            }
        }

        Image {
            x: 80
            y: 270
            source: "image://cached/menu/about.png"

            MouseArea {
                anchors.fill: parent
                onClicked: root.aboutClicked()
            }
        }

        Image {
            x: 215
            y: 340
            source: screen.muted ? "image://cached/menu/sound_on.png"
                : "image://cached/menu/sound_off.png"

            MouseArea {
                anchors.fill: parent
                onClicked: screen.noSound = !screen.noSound
            }
        }
    }

    Item {
        x: root.displacement * 1.2

        Image {
            x: 410
            y: root.replayEnabled ? 340 : 600
            visible: root.replayEnabled
            source: "image://cached/menu/replay.png"

            Behavior on y {
                NumberAnimation { duration: 800 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.replayClicked();
            }
        }

        Image {
            x: 660
            y: 410
            source: "image://cached/menu/wood.png"
        }
    }
}
