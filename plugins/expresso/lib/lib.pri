# Expresso sources
INCLUDEPATH += $$PWD
HEADERS += $$PWD/plugin.h \
           $$PWD/sprite.h \
           $$PWD/common.h \
           $$PWD/settings.h \
           $$PWD/expresso.h \
           $$PWD/pcmsound.h \
           $$PWD/pixmaptext.h \
           $$PWD/particlesystem.h \
           $$PWD/imageloader.h

SOURCES += $$PWD/plugin.cpp \
           $$PWD/common.cpp \
           $$PWD/settings.cpp \
           $$PWD/sprite.cpp \
           $$PWD/expresso.cpp \
           $$PWD/pcmsound.cpp \
           $$PWD/pixmaptext.cpp \
           $$PWD/particlesystem.cpp \
           $$PWD/imageloader.cpp

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += libpulse

    DEFINES += PCMSOUND_PULSE

    HEADERS += $$PWD/pcmsound_pulse.h
    SOURCES += $$PWD/pcmsound_pulse.cpp
} else {
    #HEADERS += $$PWD/pcmsound_dummy.h
}
