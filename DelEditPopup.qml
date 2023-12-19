import QtQuick
import QtQuick.Controls


//Popup for editing assignment
Popup {
    id: popup
    width: 200
    height: 200
    modal: false
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    function openPopup() {
        popup.open();
    }

    function closePopup() {
        popup.close();
    }

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

