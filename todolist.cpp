#include "todolist.h"

ToDoList::ToDoList(QObject *parent)
    : QObject{parent}
{

}
//Makes ToDo objects and Adds assignment to vector
void ToDoList::addAssignment(int todo_id, QString todo_description, QString toDoContent, bool todo_status)
{
    assigmmentList.push_back(new ToDo{todo_id,todo_description,toDoContent,todo_status});
    qInfo()<<"Added new assignment in C++";
    emit assignmentAdded();
}

//Returns assignment by ID from vector
ToDo* ToDoList::getAssignment(int id)
{
    //Loops through the vector and checks if the id matches
    for(int i{}; i<assigmmentList.size();i++)
    {
        if(assigmmentList[i]->getID() == id)
        {
            return assigmmentList[i];
        }
    }

    //Returns nullptr if no match
    return 0;
}

//Returns map of assignment list
QVariantList ToDoList::getAssignmentList() {
    QVariantList list;
    for (ToDo* todo : assigmmentList) {
        //Creates map with assignment data
        QVariantMap map;
        map["id"] = todo->getID();
        map["description"] = todo->getDescription();
        map["content"] = todo->getContent();
        map["status"] = todo->getStatus();
        list.append(map);
    }
    return list;
}

//Deletes assignment from vector
void ToDoList::deleteAssignment(int id) {
    for(int i = 0; i < assigmmentList.size(); ++i) {
        if(assigmmentList[i]->getID() == id) {
            delete assigmmentList[i];
            assigmmentList.removeAt(i);
            emit assignmentDeleted();
            break;
        }
    }
}



