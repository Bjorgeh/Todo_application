#include "todo.h"

//Constructor
ToDo::ToDo(QObject *parent)
    : QObject{parent}
{
}
//Constructor
ToDo::ToDo(int id, QString description, QString content, bool status, QObject *parent)
    : QObject{parent}, todo_id(id), todo_description(description), toDoContent(content), todo_status(status)
{
}

/*
 * Getters and Setters for the ToDo object
*/

//Returns ID
int ToDo::getID()  {
    return todo_id;
}

//Sets ID
void ToDo::setID(int id) {
    if (todo_id != id) {
        todo_id = id;
        qInfo()<<"ID updated in C++";
        emit idChanged();
    }
}

//Returns description
QString ToDo::getDescription()  {
    return todo_description;
}

//Sets description
void ToDo::setDescription( QString description) {
    if (todo_description != description) {
        todo_description = description;
        qInfo()<<"Description updated in C++";
        emit descriptionChanged();
    }
}

//Returns content
QString ToDo::getContent()  {
    return toDoContent;
}

//Sets content
void ToDo::setContent( QString content) {
    if (toDoContent != content) {
        toDoContent = content;
        qInfo()<<"Content updated in C++";
        emit contentChanged();
    }
}

//Returns status
bool ToDo::getStatus()  {
    return todo_status;
}

//Sets status
void ToDo::setStatus(bool status) {
    if (todo_status != status) {
        todo_status = status;
        emit statusChanged();
        qInfo()<<"status updated in C++";
    }
}

//Reads JSON - database
void ToDo::read(const QJsonObject &json) {
    if (json.contains("id") && json["id"].isDouble())
        todo_id = json["id"].toInt();

    if (json.contains("description") && json["description"].isString())
        todo_description = json["description"].toString();

    if (json.contains("content") && json["content"].isString())
        toDoContent = json["content"].toString();

    if (json.contains("status") && json["status"].isBool())
        todo_status = json["status"].toBool();
}

//Writes to JSON - database
void ToDo::write(QJsonObject &json) const  {
    json["id"] = todo_id;
    json["description"] = todo_description;
    json["content"] = toDoContent;
    json["status"] = todo_status;
}
