#ifndef TODO_H
#define TODO_H

#include <QObject>

class ToDo : public QObject
{
    Q_OBJECT
    //Sets properties for QML
    Q_PROPERTY(int id READ getID CONSTANT)
    Q_PROPERTY(QString description READ getDescription CONSTANT)
    Q_PROPERTY(QString content READ getContent CONSTANT)
    Q_PROPERTY(bool status READ getStatus CONSTANT)

public:
    explicit ToDo(QObject *parent = nullptr);
    //Constructor for ToDo class
    ToDo(int id, QString description, QString content, bool status, QObject *parent = nullptr);

    //Getters for properties
    int getID() const;
    QString getDescription() const;
    QString getContent() const;
    bool getStatus() const;

private:
    int todo_id;
    QString todo_description;
    QString toDoContent;
    bool todo_status;
};

#endif // TODO_H
