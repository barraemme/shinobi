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

var sprites = new Array();
var components = new Array();
var enemyComponents = new Array();

var db = null;
var fan = 0;
var phase = 0;
var levelCount = 0;
var levelLength = 3000;
var ticksPerEnemy = 300;


function init()
{
    var url = Qt.resolvedUrl("sprites/obstacles/");
    var files = Expresso.listDirFiles(url, "*.qml");

    for (var i = 0; i < files.length; i++)
        enemyComponents.push(files[i]);
}

function startGame(doRun)
{
    reset();
}

function reset()
{
    player.reset();
    canvas.sceneX = -player.x + 100;

    fan = 0;
    phase = 0;
    levelCount = 0;
    ticksPerEnemy = 300;
    fanSound.stop();

    var obj;

    for (var i = 0; i < sprites.length; i++) {
        obj = sprites[i];
        if (obj != null) {
            obj.visible = false;
            obj.destroy();
        }
    }

    sprites.splice(0);
}

function createObject(name, parent)
{
    var component;

    if (name in components)
        component = components[name];
    else {
        component = Qt.createComponent(name);

        if (component == null || component.status != Component.Ready) {
            console.log("error loading '" + name + "' component");
            console.log(component.errorString());
            return null;
        }

        components[name] = component;
    }

    var object = component.createObject(parent);

    if (object == null) {
        console.log("error creating object for: " + name);
        console.log(component.errorString());
        return null;
    }

    return object;
}

function tick()
{
    phase++;

    if (phase > ticksPerEnemy) {
        phase = 0;
        var i = Math.floor(Math.random() * enemyComponents.length);

        var object = createObject(enemyComponents[i], world);
        object.x = player.x + world.width;
        object.y = (world.height * 0.8 - object.height) * (1.0 - Math.random());
        object.xVelocity = - (200 + 100 * Math.random())

        if (!object.fixedRotation)
            object.rotation = 10 + Math.random() * 340;

        sprites.push(object);
    }

    if (ticksPerEnemy > 60)
        ticksPerEnemy = Math.max(60, ticksPerEnemy - 0.02);

    if (!fan) {
        fanSound.stop();
    } else {
        var distPercent = Math.abs(fan.x - player.x) / levelLength;
        fanSound.volume = Math.round((1.0 - distPercent) * 5 + 5) / 10.0;

        fanSound.play();
    }

    if (player.x > (levelCount + 1) * levelLength) {
        levelCount++;

        if (fan)
            fan.running = false;

        fan = createObject("sprites/Fan.qml", world);
        fan.x = (levelCount + 1) * levelLength;
        fan.y = -30;

        sprites.push(fan);
    }

    if (player.alive) {
        screen.score = parseInt(player.x / screen.metersByPixel);

        var ppos = -player.x + 100;
        var diff = Math.min(0, ppos - canvas.sceneX);
        background.offset = (background.offset - diff) % background.pixelLoop
        canvas.sceneX = ppos;
    } else {
        if (player.x + player.width < -canvas.sceneX) {
            restartGame();
        }
    }
}

function restartGame()
{
    screen.highScore = Math.max(screen.highScore,
                                screen.score)
    screen.score = 0;

    startGame(true);
}
