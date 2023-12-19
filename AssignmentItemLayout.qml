import QtQuick
import QtQuick.Controls
import "./AssignmentModuleFunctions.js" as AssignmentFunctions

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
                    status = !status;
                    AssignmentFunctions.updateImage(image, status);
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
    //Shows image when component is completed
    Component.onCompleted: {
        AssignmentFunctions.updateImage(image, status);
    }
}
