import QtQuick
import QtQuick.Window
import QtQuick.Controls

//Main window
Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("ToDo")

    // ToDoPage properties
    property string headerColor: "white"
    property string bkg: "lightgray"

    //Page 1
    property string page1HeaderText: "ToDo"

    //Custom page for ToDo app
    ToDoPage{
        anchors.fill: parent
        backgroundColor: bkg
        pageHeaderColor: headerColor
        headerText: page1HeaderText
    }
}
