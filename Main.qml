import QtQuick
import QtQuick.Window
import QtQuick.Controls

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

    //Page2


    ToDoPage{
        anchors.fill: parent
        backgroundColor: bkg
        pageHeaderColor: headerColor
        headerText: page1HeaderText
    }
}
