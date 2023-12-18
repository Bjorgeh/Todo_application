#include "todo.h"

ToDo::ToDo(QObject *parent)
    : QObject{parent}
{

}
//Constructor for ToDo class
ToDo::ToDo(int id, QString description, QString content, bool status, QObject *parent)
{
    todo_id = id;
    todo_description = description;
    toDoContent = content;
    todo_status = status;
}

/*
 * Getters for properties
*/
int ToDo::getID() const
{
    return todo_id;
}
QString ToDo::getDescription() const {
    return todo_description;
}
QString ToDo::getContent() const {
    return toDoContent;
}
bool ToDo::getStatus() const {
    return todo_status;
}


