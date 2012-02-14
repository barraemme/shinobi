import QtQuick 1.1
import Expresso 1.0

Item {
    id: screen

    property int score : 0
    property int offset: 0
    property int metersByPixel: 120
    property real verticalProgress: 0.0
    property alias noSound: settings.noSound
    property alias highScore : settings.highScore
    property bool running: screen.state == "running"
    property bool muted: noSound || !appActive
    property bool appActive: Qt.application.active

    function start() {
        gameScene.init();
        screen.state = "menu";
    }

    onAppActiveChanged: {
        if (screen.running)
            screen.state = "menu";
    }

    Settings {
        id: settings
        property int highScore: 0
        property bool noSound: false
    }

    Item {
        width: parent.width
        height: parent.height
        y: screen.verticalProgress * -gameScene.verticalDisplacement

        Landscape {
            id: background
            anchors.fill: parent
            displacement: screen.offset
        }

        LoadMenu {
            id: loadMenu
            offset: screen.offset
            anchors.fill: parent
        }

        AboutMenu {
            id: aboutMenu
            visible: false
            offset: screen.offset
            anchors.fill: parent
            onBackClicked: screen.state = "menu";
        }

        MainMenu {
            id: mainMenu
            visible: false
            anchors.fill: parent
            displacement: screen.width - screen.offset

            onPlayClicked: {
                replayEnabled = true;
                screen.state = "running";
            }
            onReplayClicked: {
                gameScene.restart();
                screen.state = "running";
            }
            onAboutClicked: {
                screen.state = "about";
            }
        }

        GameScene {
            id: gameScene
            opacity: 0.0
            visible: false
            running: false
            width: parent.width
            height: parent.height
            y: verticalDisplacement
            displacement: screen.width * 2 - screen.offset
            highScoreFlagPos: screen.highScore * screen.metersByPixel
        }
    }

    Item {
        id: topBar
        y: -50
        height: 50
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right

        Score {
            id: score
            value: screen.score
            anchors {
                verticalCenter: fuel.verticalCenter
                right: fuel.left
                rightMargin: 40
            }
        }

        FuelIndicator {
            id: fuel
            value: gameScene.fuel
            count: gameScene.fuelPlus
            anchors {
                top: parent.top
                right: parent.right
                topMargin: 10
                rightMargin: 100
            }
        }

        Image {
            anchors.top: parent.top
            anchors.right: parent.right
            source: "image://cached/pause.png"

            MouseArea {
                anchors.fill: parent
                onClicked: screen.state = "menu";
            }
        }
    }

    states : [
        State {
            name: "about"
            PropertyChanges { target: loadMenu; visible: false; }
            PropertyChanges { target: mainMenu; visible: false; }
            PropertyChanges { target: aboutMenu; visible: true; }
            PropertyChanges { target: screen; offset: 0; verticalProgress: 0; }
            PropertyChanges { target: gameScene; visible: false; running: false; opacity: 0.0; }
        },
        State {
            name: "menu"
            PropertyChanges { target: loadMenu; visible: false; }
            PropertyChanges { target: mainMenu; visible: true; }
            PropertyChanges { target: aboutMenu; visible: false; }
            PropertyChanges { target: screen; offset: screen.width; verticalProgress: 0; }
            PropertyChanges { target: gameScene; visible: false; running: false; opacity: 0.0; }
        },
        State {
            name: "running"
            PropertyChanges { target: loadMenu; visible: false; }
            PropertyChanges { target: mainMenu; visible: false; }
            PropertyChanges { target: aboutMenu; visible: false; }
            PropertyChanges { target: topBar; visible: true; y: 0; }
            PropertyChanges { target: screen; offset: screen.width * 2; verticalProgress: 1.0; }
            PropertyChanges { target: gameScene; visible: true; running: true; opacity: 1.0; }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "menu"

            SequentialAnimation {
                PropertyAction { target: mainMenu; property: "visible" }
                NumberAnimation { target: screen; property: "offset";
                                  duration: 1600; easing.type: Easing.InOutQuad; }
                PropertyAction { target: loadMenu; property: "visible" }
            }
        },
        Transition {
            from: "about"
            to: "menu"
            reversible: true

            SequentialAnimation {
                PropertyAction { target: mainMenu; property: "visible" }
                NumberAnimation { target: screen; property: "offset";
                                  duration: 1600; easing.type: Easing.InOutQuad; }
                PropertyAction { target: aboutMenu; property: "visible" }
            }
        },
        Transition {
            from: "menu"
            to: "running"
            reversible: true

            SequentialAnimation {
                PropertyAction { target: topBar; property: "visible" }
                PropertyAction { target: gameScene; property: "visible" }
                ParallelAnimation {
                    NumberAnimation { target: screen; property: "offset";
                                      duration: 1600; easing.type: Easing.InOutQuad; }
                    NumberAnimation { target: topBar; property: "y";
                                      duration: 1600; easing.type: Easing.InOutQuad; }
                    NumberAnimation { target: screen; property: "verticalProgress";
                                      duration: 1600; easing.type: Easing.InOutQuad; }
                    NumberAnimation { target: gameScene; property: "opacity";
                                      duration: 1600; easing.type: Easing.InOutQuad; }
                }
                PropertyAction { target: mainMenu; property: "visible" }
                PropertyAction { target: gameScene; property: "running" }
            }
        }
    ]

    ParticleSystem {
        anchors.fill: parent
        rate: 12
        lifeSpan: 200
        xVelocity: -15
        yVelocity: 1
        automatic: screen.appActive
        originRect: Qt.rect(width, 0, 50, height * 0.8)
        sources: [
            "image://cached/particles/leaf1.png",
            "image://cached/particles/leaf2.png",
            "image://cached/particles/leaf3.png",
            "image://cached/particles/dust1.png",
            "image://cached/particles/dust2.png",
            "image://cached/particles/dust3.png"
        ]
    }

    MouseArea {
        id: blocker
        anchors.fill: parent
        visible: (aboutMenu.visible && mainMenu.visible) ||
            (mainMenu.visible && gameScene.visible) ||
            (mainMenu.visible && loadMenu.visible)
    }

    PcmSound {
        id: windSound
        muted: screen.muted
        source: "sounds/wind.wav"
        loops: PcmSound.Infinite
    }

    PcmSound {
        id: tuneSound
        muted: screen.muted
        paused: !screen.running
        source: "sounds/tune.wav"
        loops: PcmSound.Infinite
    }

    PcmSound {
        id: fanSound
        muted: screen.muted
        paused: !screen.running
        source: "sounds/fan.wav"
        loops: PcmSound.Infinite
    }

    Component.onCompleted: {
        windSound.play();
        tuneSound.play();
    }
}
