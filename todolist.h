#ifndef TODOLIST_H
#define TODOLIST_H
#include "todo.h"
#include <QObject>
#include <QVariant>

//Class is used to create a ToDoList object
class ToDoList : public QObject
{
    Q_OBJECT

public:
    explicit ToDoList(QObject *parent = nullptr);

    //Makes ToDo objects and Adds assignment to vector
    Q_INVOKABLE void addAssignment(int todo_id,
                       QString todo_description,
                       QString toDoContent,
                       bool todo_status);

    //Returns assignment by ID from vector
    Q_INVOKABLE ToDo* getAssignment(int id);

    //Returns assignment list
    Q_INVOKABLE QVariantList getAssignmentList();

    //Deletes assignment from vector
    Q_INVOKABLE void deleteAssignment(int id);

private:
    //Vector for assignments
    QVector<ToDo*> assigmmentList;

signals:
    //Signals for the QProperties
    void assignmentAdded();
    void assignmentDeleted();


};

#endif // TODOLIST_H
