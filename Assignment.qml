import QtQuick

//Item for Assignments
Item {
    id: assignmentObject
    property int toDoID: 0
    property string description: ""
    property string content: ""
    property bool status: false
    signal customStatusChanged()

    //function to update the image
    function updateImage() {
        image.source = status
                      ? "https://static.vecteezy.com/system/resources/thumbnails/011/858/556/small_2x/green-check-mark-icon-with-circle-tick-box-check-list-circle-frame-checkbox-symbol-sign-png.png"
                      : "https://cdn-icons-png.flaticon.com/512/169/169779.png";
    }

    property string newcolor: "white"

    //runs when the status is changed
    Component.onCompleted: updateImage()

    //Rectangle for item
    Rectangle {
        anchors.fill: parent
        color: newcolor

        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: image.left
            text: description
            elide: Text.ElideRight
        }

        Image {
            id: image
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(description + "\n" + content + "\n" + status)
                status = !status
                customStatusChanged()

            }
        }
    }

    onCustomStatusChanged: updateImage()
}
