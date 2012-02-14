#include <QtGui>
#include <QtDeclarative>
#include "box2dplugin.h"

#include "qmlapplicationviewer.h"
#include "plugin.h"

#ifndef QT_NO_OPENGL
#include <QGLWidget>
#endif

// Lock orientation in Symbian
#ifdef Q_OS_SYMBIAN
#include <eikenv.h>
#include <eikappui.h>
#include <aknenv.h>
#include <aknappui.h>
#endif

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    #include <QAccelerometer>
    #include "accelerometerfilter.h"

    QTM_USE_NAMESPACE
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));



#if defined Q_WS_MAEMO_5
    QRect screenGeometry(0, 0, 800, 480);
#elif defined Q_OS_SYMBIAN
    QRect screenGeometry(0, 0, 640, 360);
#else
    QRect screenGeometry(100, 100, 800, 480);
 #endif

    //QDeclarativeView view;
    QmlApplicationViewer view;

    Box2DPlugin box2d;
    box2d.registerTypes("Box2D");
    ExpressoPlugin expresso;
    expresso.registerTypes("Expresso");
    expresso.initializeEngine(view.engine(), "Expresso");

#ifndef QT_NO_OPENGL
    // Use QGLWidget to get the opengl support if available
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);

    QGLWidget *glWidget = new QGLWidget(format);
    glWidget->setAutoFillBackground(false);
    view.setViewport(glWidget);     // ownership of glWidget is taken
#endif

    QDeclarativeContext *context = view.rootContext();
    context->setContextProperty("screenWidth", screenGeometry.width());
    context->setContextProperty("screenHeight", screenGeometry.height());

    //view.setSource(QUrl("qrc:/qml/shinobi/main.qml"));

    //QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &app, SLOT(quit()));

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    QAccelerometer sensor;
    AccelerometerFilter filter;

    sensor.addFilter(&filter);

    QObject::connect(&filter, SIGNAL(readingChanged(const QVariant&, const QVariant&)),
                     view.rootObject(), SLOT(gravityChanged(const QVariant&, const QVariant&)));

    sensor.start();
#endif

    view.setGeometry(screenGeometry);

    view.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    //view.setMainQmlFile(QLatin1String("qml/shinobi/main.qml"));
/*#ifdef MEEGO_HARMATTAN
    view.engine()->addImportPath("/opt/pathwind/plugins");

    view.setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
    view.setMainQmlFile(QLatin1String("/opt/pathwind/qml/shinobi/main.qml"));
#else*/
    view.setMainQmlFile(QLatin1String("qml/shinobi/main.qml"));
//#endif
    view.showExpanded();

    return app->exec();
}
