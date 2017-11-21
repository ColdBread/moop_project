#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appcore.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    AppCore appCore;    // Создаём ядро приложения
        QQmlContext *context = engine.rootContext();    // Создаём корневой контекст
        /* Загружаем объект в контекст для установки соединения,
         * а также определяем имя, по которому будет происходить соединение
         * */
        context->setContextProperty("appCore", &appCore);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
