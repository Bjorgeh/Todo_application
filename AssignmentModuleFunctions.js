.pragma library

//changes image source when status is changed
function updateImage(image, status) {
    image.source = status
        ? "https://static.vecteezy.com/system/resources/thumbnails/011/858/556/small_2x/green-check-mark-icon-with-circle-tick-box-check-list-circle-frame-checkbox-symbol-sign-png.png"
        : "https://cdn-icons-png.flaticon.com/512/169/169779.png";
}

//binds assignment object to todoitem
function bindToDoItem(todoItem, assignmentObject) {
    if (todoItem !== null) {
        assignmentObject.toDoID = todoItem.id;
        assignmentObject.description = todoItem.description;
        assignmentObject.content = todoItem.content;
        assignmentObject.status = todoItem.status;

        todoItem.descriptionChanged.connect(function() {
            assignmentObject.description = todoItem.description;
        });
        todoItem.contentChanged.connect(function() {
            assignmentObject.content = todoItem.content;
        });
        todoItem.statusChanged.connect(function() {
            assignmentObject.status = todoItem.status;
            updateImage(assignmentObject.image, assignmentObject.status);
        });
    }
}

//updates list model when assignment list is changed
function updateListModel(listModel, assignmentList) {
    listModel.clear();
    var fullList = assignmentList.getAssignmentList();
    for (var i = 0; i < fullList.length; i++) {
        listModel.append({
            "name": fullList[i].description,
            "description": fullList[i].content,
            "toDoID": fullList[i].id,
            "status": fullList[i].status
        });
    }
}
