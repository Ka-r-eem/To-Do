import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/CustomFormField.dart';
import 'package:todo_app/database/TasksDao.dart';
import 'package:todo_app/database/model/Task.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/DialogUtils.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var DescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CustomFormFeild(
                hintText: 'Title',
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please Enter Task Title";
                  }
                },
                controller: titleController),
            CustomFormFeild(
                hintText: 'Description',
                lines: 4,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please Enter Task Description";
                  }
                },
                controller: DescController),
            InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1,
                  ))),
                  child: Text(selectedDate == null
                      ? "Date"
                      : "${selectedDate?.day} / ${selectedDate?.month}/  ${selectedDate?.year}")),
            ),
            Visibility(
              visible: showDateError,
              child: Text(
                "Please Select Task Date",
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).colorScheme.error),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  bool isValidForm() {
    bool isValid = true;

    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      setState(() {
        showDateError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    if (!isValidForm()) return;

    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    Task task = Task(
        title: titleController.text,
        description: DescController.text,
        datetime: Timestamp.fromMillisecondsSinceEpoch(
            selectedDate?.millisecondsSinceEpoch ?? 0));
    DialogUtils.showLoading(context);
    await TasksDao.createTask(task, authProvider.databaseUser!.id!);
  DialogUtils.hideDialog(context);
  DialogUtils.showMessage(context, "Task Created Succesfully " ,isCancelable: false
      , posActionTitle: "OK",
    posAction: (){
    Navigator.pop(context)
    ;},

  );
  }

  bool showDateError = false;

  DateTime? selectedDate = null;

  void showTaskDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    setState(() {
      selectedDate = date;
      if (selectedDate != null) {
        showDateError = false;
      }
    });
  }
}
