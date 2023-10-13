import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/TasksDao.dart';
import 'package:todo_app/database/model/Task.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/DialogUtils.dart';
import 'package:todo_app/ui/home/TasksList/editTask.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget(this.task);

  bool unDone = true;
  bool done = false;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: "Delete",
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          ),
          SlidableAction(
            onPressed: (context) {
              showEditTaskBottomSheet(widget.task);
            },
            icon: Icons.edit,
            backgroundColor: Colors.greenAccent,
            label: "Update",
            // borderRadius: const BorderRadius.only(
            //     topRight: Radius.circular(12),
            //     bottomRight: Radius.circular(12))
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
                width: 4,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.task.isDone!
                      ? Color(0xFF61E757)
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(18),
                )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.task.isDone!
                            ? Color(0xFF61E757)
                            : Theme.of(context).primaryColor),
                  ),
                  Text(
                    widget.task.description ?? "",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )),
            InkWell(
              onTap: () {
                makeTaskDone();
                setState(() {});
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    color: widget.task.isDone!
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: widget.task.isDone!
                      ? const Text(
                          "Done!",
                          style: TextStyle(
                              color: Color(0xFF61E757),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      : const Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        )),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(context, "Are You Sure To Delete This Task",
        posActionTitle: "YES", negActionTitle: "Cancel", posAction: () {
      deleteTaskFromFireStore();
    });
  }

  void deleteTaskFromFireStore() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    // DialogUtils.showLoading(context , isCancelable: false);
    await TasksDao.removeTask(widget.task.id!, authProvider.databaseUser!.id!);
    // DialogUtils.hideDialog(context);
  }

  void makeTaskDone() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    await TasksDao.finishTask(widget.task.id!, authProvider.databaseUser!.id!);
  }

  void showEditTaskBottomSheet(Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return editTask(task);
        });
  }
}
