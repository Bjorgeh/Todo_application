#include "database.h"
#include <QCoreApplication>

//Constructor for Database object
Database::Database(ToDoList *todoList, const QString &filename, QObject *parent)
    : QObject(parent), m_todoList(todoList), m_filename(filename) {
    //Get the full path to the file
    QString filePath = QCoreApplication::applicationDirPath() + "/" + filename;
    m_filename = filePath;
    //Runs readFromFile function
    readFromFile();
}
//Destructor
Database::~Database() {
    //Writes to file when program closes
    writeToFile();
}

//Reads from file if file exists
void Database::readFromFile() {
    QFile file(m_filename);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return;
    }

    //Makes json readable and puts it in a QJsonArray
    QByteArray saveData = file.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    QJsonArray jsonArr = loadDoc.array();

    //Loops through the array and makes a ToDo object for each object in the array
    for (const QJsonValue &value : jsonArr) {
        QJsonObject obj = value.toObject();
        ToDo *todo = new ToDo();
        todo->read(obj);
        //Adds the ToDo object to the ToDoList vector
        m_todoList->addAssignment(todo->getID(), todo->getDescription(), todo->getContent(), todo->getStatus());
    }
}

//Writes to file
void Database::writeToFile() {
    QFile file(m_filename);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return;
    }

    //Makes json readable and puts it in a QJsonArray
    QJsonArray jsonArr;
    QVariantList list = m_todoList->getAssignmentList();
    for (const QVariant &var : list) {
        QVariantMap map = var.toMap();
        QJsonObject obj;

        //Inserts data into the object
        obj["id"] = map["id"].toInt();
        obj["description"] = map["description"].toString();
        obj["content"] = map["content"].toString();
        obj["status"] = map["status"].toBool();
        jsonArr.append(obj);
    }
    //Writes to file
    QJsonDocument saveDoc(jsonArr);
    file.write(saveDoc.toJson());
}
