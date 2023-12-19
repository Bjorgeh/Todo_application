#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QJsonDocument>
#include "todo.h"
#include "todolist.h"

//Class is used to create a Database object and load data from file
class Database : public QObject {
    Q_OBJECT

public:
    //Takes in a ToDoList object and a filename
    explicit Database(ToDoList *todoList, const QString &filename, QObject *parent = nullptr);
    ~Database();

    //Reads and Writes to JSON - database
    void readFromFile();
    void writeToFile();

private:
    //variables for the Objects
    ToDoList *m_todoList; //pointer to ToDoList object
    QString m_filename;
};

#endif // DATABASE_H

