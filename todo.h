#ifndef TODO_H
#define TODO_H

#include <QObject>
#include <QJsonObject>


//Class is used to create a ToDo object
class ToDo : public QObject
{
    Q_OBJECT

    //QProperties of the ToDo object
    Q_PROPERTY(int id READ getID WRITE setID NOTIFY idChanged)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString content READ getContent WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(bool status READ getStatus WRITE setStatus NOTIFY statusChanged)

public:
    explicit ToDo(QObject *parent = nullptr);
    //Constructor
    ToDo(int id, QString description, QString content, bool status, QObject *parent = nullptr);

    //Getters and Setters for the ToDo object
    Q_INVOKABLE int getID() ;
    Q_INVOKABLE void setID(int id);

    Q_INVOKABLE QString getDescription() ;
    Q_INVOKABLE void setDescription( QString description);

    Q_INVOKABLE QString getContent() ;
    Q_INVOKABLE void setContent( QString content);

    Q_INVOKABLE bool getStatus() ;
    Q_INVOKABLE void setStatus(bool status);

    //Reads and Writes to JSON - database
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

signals:
    //Signals for the QProperties
    void idChanged();
    void descriptionChanged();
    void contentChanged();
    void statusChanged();

private:
    //variables for the Objects
    int todo_id;
    QString todo_description;
    QString toDoContent;
    bool todo_status;
};

#endif // TODO_H
