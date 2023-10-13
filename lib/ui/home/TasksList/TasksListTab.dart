import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/database/TasksDao.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/home/TasksList/TaskWidget.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  DateTime selectedDay = DateTime.now();


  @override
  Widget build(BuildContext context) {


    var authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        CalendarTimeline(

          onDateSelected: (date){
            setState(() {
              selectedDay = date ;

            });
          },

          initialDate: selectedDay,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),

          leftMargin: 20,
          monthColor: Theme.of(context).primaryColor,
          dayColor: Theme.of(context).primaryColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        SizedBox(height: 20,),
        Expanded(
            child: StreamBuilder(
          stream: TasksDao.listenForTasks(
              authProvider.databaseUser!.id!, selectedDay),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //loading
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              // error
              return Center(
                child: Column(
                  children: [
                    const Text("SomeThing Went Wrong"),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Try Again"))
                  ],
                ),
              );
            }
            var tasksList = snapshot.data;
            return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskWidget(tasksList![index]);
                },
                itemCount: tasksList?.length ?? 0);
          },
        ))
      ],
    );
  }
}
