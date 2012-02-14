QT       += declarative opengl

TARGET = shinobi

include(plugins/qml-box2d/box2d-static.pri)
include(plugins/expresso/expresso-static.pri)

# Add more folders to ship with the application, here
folder_01.source = qml/shinobi
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE20A2C6D

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp
HEADERS += accelerometerfilter.h

CONFIG += meegotouch
DEFINES += MEEGO_HARMATTAN


CONFIG += link_pkgconfig
PKGCONFIG += libresourceqt1

OUTDIR = /opt/shinobi

resources.files = qml
resources.path = $$OUTDIR

target.path = $$OUTDIR/bin

desktop.path = /usr/share/applications
desktop.files += $${TARGET}.desktop

icon80.path = /usr/share/icons/hicolor/80x80/apps
icon80.files += data/80x80/$${TARGET}.png

#BOX2D_DIR = $$[QT_INSTALL_IMPORTS]/Box2D
#EXPRESSO_DIR = $$[QT_INSTALL_IMPORTS]/Expresso

#box2dplugin.path = $$OUTDIR/plugins/Box2D
#box2dplugin.files += $$BOX2D_DIR/libBox2D.so $$BOX2D_DIR/qmldir

#expressoplugin.path = $$OUTDIR/plugins/Expresso
#expressoplugin.files += $$EXPRESSO_DIR/libexpresso.so $$EXPRESSO_DIR/qmldir

INSTALLS += target resources desktop icon80
#INSTALLS += box2dplugin
#INSTALLS += expressoplugin


# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

RESOURCES += \
    resources.qrc
