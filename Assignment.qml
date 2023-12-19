import QtQuick
import QtQuick.Controls

//Item for Assignments
Item {
    id: assignmentObject
    property int toDoID: 0
    property string description: ""
    property string content: ""
    property bool status: false
    property string newcolor: "white"
    signal customStatusChanged()

    //function to update the image
    function updateImage() {
        image.source = status
                ? "https://static.vecteezy.com/system/resources/thumbnails/011/858/556/small_2x/green-check-mark-icon-with-circle-tick-box-check-list-circle-frame-checkbox-symbol-sign-png.png"
                : "https://cdn-icons-png.flaticon.com/512/169/169779.png";
    }

    //Binds the properties of the item to the properties of the toDoItem
    function bindToDoItem(todoItem) {
        if (todoItem !== null) {
            toDoID = todoItem.id;
            description = todoItem.description;
            content = todoItem.content;
            status = todoItem.status;

            todoItem.descriptionChanged.connect(function() {
                description = todoItem.description;
            });
            todoItem.contentChanged.connect(function() {
                content = todoItem.content;
            });
            todoItem.statusChanged.connect(function() {
                status = todoItem.status;
                updateImage();
            });
        }
    }

    //Defines function for updating the list model
    function updateListModel() {
        listModel.clear();
        var fullList = assignmentList.getAssignmentList();
        for (var i = 0; i < fullList.length; i++) {
            listModel.append({"name": fullList[i].description,
                                 "description": fullList[i].content,
                                 "toDoID": fullList[i].id,
                                 "status": fullList[i].status});
        }
    }

    //runs when item completed
    Component.onCompleted: {
        updateImage();
        assignmentList.assignmentDeleted.connect(updateListModel);
    }

    //Rectangle for item
    Rectangle {
        anchors.fill: parent
        color: newcolor

        //Sets text for list element
        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: image.left
            text: toDoID+ " " +description
            elide: Text.ElideRight
        }

        //Image for status
        Image {
            id: image
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
        }

        //If left button clicked, status is changed. If right button clicked, context menu is opened
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouseEvent) {
                //Opens popup with differende options
                if (mouseEvent.button === Qt.RightButton) {
                    contextMenu.popup();

                    //Changes status of assignment
                }
                else if (mouseEvent.button === Qt.LeftButton) {
                    var todoItem = assignmentList.getAssignment(toDoID);
                    if (todoItem !== null) {
                        console.log("Changing status of item ID:", toDoID); // Debug-utskrift

                        console.log("Changed status from: "+todoItem.getStatus())
                        todoItem.setStatus(!todoItem.getStatus());
                    }
                }
            }

            //Shows content of assignment when mouse is hovered over
            ToolTip {
                visible: parent.containsMouse
                text: content
                delay: 100 //ms delay
            }
        }
    }

    //Menu for deleting or editing assignment
    Menu {
        id: contextMenu
        MenuItem {
            text: "Delete"
            onTriggered: {
                console.log("Deleting assignment with ID:", toDoID);
                assignmentList.deleteAssignment(toDoID);

            }
        }
        MenuItem { text: "Edit"
            onTriggered:{
                console.log("Edit was triggered")
                popup.open()}}
    }

    //Popup for editing assignment
    Popup {
        id: popup
        width: 200
        height: 200
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        //Rectangle for popup
        Rectangle {
            width: parent.width
            height: parent.height
            color: "lightgrey"
            border.color: "black"

            //Column with textfields and buttons
            Column{
                anchors.centerIn: parent
                Text {
                    text: "Edit "+ description
                }
                TextField{
                    id: newDescription
                    placeholderText: description
                }
                TextField{
                    id: newContent
                    placeholderText: content
                }
                Button {
                    text: "Save"

                    //When button is clicked, the assignment is updated with the new text
                    onClicked: {
                        var todoItem = assignmentList.getAssignment(toDoID);
                        if (todoItem) {

                            //Uses placeholder text if textfield empty
                            var descriptionToUpdate = newDescription.text !== "" ? newDescription.text : newDescription.placeholderText;
                            var contentToUpdate = newContent.text !== "" ? newContent.text : newContent.placeholderText;

                            //Updates assignment
                            todoItem.setDescription(descriptionToUpdate);
                            todoItem.setContent(contentToUpdate);
                        }

                        //Closes popup, prints data and updates model
                        popup.close();
                        console.log("New info: " + todoItem.getDescription() + " : " + todoItem.getContent())
                        updateListModel();

                    }
                }
            }
        }
    }

    //Changes image when status is changed
    onCustomStatusChanged: updateImage()

}
