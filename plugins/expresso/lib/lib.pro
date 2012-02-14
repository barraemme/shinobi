TEMPLATE = lib
CONFIG += plugin
TARGET = $$qtLibraryTarget(expresso)

QT += declarative

HEADERS += plugin.h \
           sprite.h \
           common.h \
           settings.h \
           expresso.h \
           pcmsound.h \
           pixmaptext.h \
           particlesystem.h \
           imageloader.h

SOURCES += plugin.cpp \
           common.cpp \
           settings.cpp \
           sprite.cpp \
           expresso.cpp \
           pcmsound.cpp \
           pixmaptext.cpp \
           particlesystem.cpp \
           imageloader.cpp

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += libpulse

    DEFINES += PCMSOUND_PULSE

    HEADERS += $$PWD/pcmsound_pulse.h
    SOURCES += $$PWD/pcmsound_pulse.cpp
} else {
    HEADERS += $$PWD/pcmsound_dummy.h
}

TARGETPATH = Expresso
target.path = $$[QT_INSTALL_IMPORTS]/$$TARGETPATH

qmldir.files = $$PWD/qmldir
qmldir.path = $$[QT_INSTALL_IMPORTS]/$$TARGETPATH

INSTALLS += target qmldir

