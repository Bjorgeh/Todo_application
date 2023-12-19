#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "todolist.h"
#include "database.h"
#include <QQmlContext>

//Main function
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //Makes object of ToDoList class
    ToDoList todoList;
    //Makes database object and loads data from file
    Database database(&todoList,"todo_data.json");

    //Test assignments
//    todoList.addAssignment(1,"Coding","Make new QML module",false);
//    todoList.addAssignment(2,"Sleep","Make it 8 hours",false);
//    todoList.addAssignment(3,"Cake","Eat a lot!",true);
//    todoList.addAssignment(4,"Drive","Drive like Petter Solberg",false);
//    todoList.addAssignment(5,"Bath","swim a mile",false);

    const QUrl url(u"qrc:/todo_list/Main.qml"_qs);

    //Makes objects available to QML
    engine.rootContext()->setContextProperty("assignmentList", &todoList);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
