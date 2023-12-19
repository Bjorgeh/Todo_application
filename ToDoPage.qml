import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import "./AssignmentModuleFunctions.js" as AssignmentFunctions

//Page for assignments
Page {

    //Runs when page is completed
    Component.onCompleted: {
        fillListModel();
    }

    //Fills listmodel with assignments
    function fillListModel() {
        var fullList = assignmentList.getAssignmentList();
        for (var i = 0; i < fullList.length; i++) {
            listModel.append({"name": fullList[i].description,
                                 "description": fullList[i].content,
                                 "toDoID": fullList[i].id,
                                 "status": fullList[i].status
                             });
        }
    }

    //Defines properties
    property string pageHeaderColor: ""
    property string backgroundColor: ""
    property string headerText: ""

    property string infoTextContent: "\nAdd new assignment above.\n"+
                                     "Hover to view content.\n"+
                                     "Rightclick on an assignment to edit.\n"+
                                     "Leftclick on an assignment to mark as done.\n"

    //Defines listmodel
    ListModel {
        id: listModel
    }

    //Header rectangle
    Rectangle{
        id: header
        anchors.top: parent.top

        height: parent.height/5
        width: parent.width

        color: pageHeaderColor
        Text {
            anchors.centerIn: parent
            text: headerText
        }
    }

    //Body rectangle
    Rectangle{
        anchors.top: header.bottom
        height: parent.height - header.height
        width: parent.width
        color: backgroundColor

        //Left body
        Rectangle{
            id: leftBody
            anchors.left: parent.left
            anchors.top: header.bottom
            height: parent.height
            width: parent.width/2
            color: "transparent"
            border.color: "black"
            border.width: 2

            //Column for textfields and buttons
            Column{
                anchors.centerIn: parent

                TextField{
                    id: nameField
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Category"
                }

                TextField{
                    id: descriptionField
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "WhatToDo?"
                }

                Button{
                    id: addButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Add"
                    onClicked: {
                        /*
                        //Sets variables for assignment testing

                        var assignment = assignmentList.getAssignment(1);
                        var fullList = assignmentList.getAssignmentList();

                        //Gets all assignments
                        console.log(fullList[1].id);
                        console.log(fullList[1].description);
                        console.log(fullList[1].content);
                        console.log(fullList[1].status);

                        if (assignment) {
                            console.log(assignment.id)
                            console.log(assignment.description);
                            console.log(assignment.content);
                            console.log(assignment.status);
                        } else {
                            console.log("Assignment not found");
                        }
*/

                        //Checks if fields are empty
                        if(nameField.text === "" && descriptionField.text === ""){
                            infoText.text = "Please fill in both fields";
                        } else if(nameField.text === ""){
                            infoText.text = "Please fill in category field";
                        } else if(descriptionField.text === ""){
                            infoText.text = "Please fill in description field";
                        } else {
                            infoText.text = "";
                        }

                        //Adds assignment to listmodel
                        if(nameField.text !== "" && descriptionField.text !== ""){
                            //Adds new assignment to todo
                            assignmentList.addAssignment(listModel.count+1,nameField.text, descriptionField.text,false);
                            listModel.append({"name": nameField.text, "description": descriptionField.text, "toDoID": listModel.count + 1});
                            infoText.text = infoTextContent
                        }
                    }
                }
                //Sets dynamic info text
                Text{
                    id: infoText
                    text: infoTextContent
                }
            }
        }

        //Right body
        Rectangle{
            id: rightBody
            anchors.right: parent.right
            anchors.top: header.bottom
            height: parent.height
            width: parent.width/2
            color: "transparent"
            border.color: "black"
            border.width: 2

            //Listview for assignments
            ListView {
                anchors.fill: parent
                model: listModel

                delegate: Rectangle {
                    id: test
                    width: ListView.view.width
                    height: 40
                    color: index % 2 == 0 ? "lightblue" : "lightgray"

                    //Model for assignments
                    Assignment {
                        newcolor: test.color
                        toDoID: model.toDoID
                        description: model.name
                        content: model.description
                        status: model.status ? true : false
                        anchors.fill: parent

                        //Runs when assignment is added
                        Component.onCompleted: {
                            var todoItem = assignmentList.getAssignment(model.toDoID);
                            if (todoItem) {
                                AssignmentFunctions.bindToDoItem(todoItem);
                            }
                        }
                    }
                }
            }
        }
    }
}


