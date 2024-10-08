#include "backend.h"
#include "Lib/database/dbman.h"
#include <QJsonObject>
#include "Lib/models/BranchModel.h"


Backend::Backend(QGuiApplication &app, QObject *parent)
    : QObject{parent}, dbMan(nullptr)
{
    dbMan = new DbMan(this);
    QQmlApplicationEngine engine;

    //register
    qmlRegisterType<BranchModel>("BranchModel",1,0,"BranchModel");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
}

void Backend::initiate()
{
    engine.rootContext()->setContextProperty("backend", this);
    engine.rootContext()->setContextProperty("dbMan", dbMan);

    engine.loadFromModule("Roshangaran", "LoginWindow");
}

void Backend::loadHome()
{
    QJsonObject user = dbMan->getUserJson();
    engine.rootContext()->setContextProperty("user", user);
    engine.loadFromModule("Roshangaran", "HomeWindow");
}
