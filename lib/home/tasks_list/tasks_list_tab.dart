import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/home/tasks_list/task_widget.dart';
import 'package:todo_app/providers/settings_provider.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  /*====================[Variables]====================*/
  late SettingsProvider settingsProvider;
  DateTime selectedDate = DateTime.now();

  /*==================================================*/

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
        child: Column(
      children: [
        CalendarTimeline(
          showYears: true,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            if (date == null) return;
            setState(() {
              selectedDate = date;
            });
          },
          leftMargin: 20,
          monthColor: settingsProvider.isDark() ? Colors.white : Colors.black,
          dayColor: settingsProvider.isDark() ? Colors.white : Colors.black,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Theme.of(context).primaryColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
          stream: MyDatabase.listenForTaskRealTimeUpdates(selectedDate),
          builder: (buildContext, snapshot) {
            // execute if there's an error
            if (snapshot.hasError) {
              return  Center(
                  child: Text(
                'Error Loading Date,try again later',
                style: Theme.of(context).textTheme.titleMedium,
              ));
            }
            // execute if data is loading
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // build List if everything is ok
            var data =
                snapshot.data?.docs.map((element) => element.data()).toList();
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return TaskWidget(data[index]);
                });
          },
        ))
      ],
    ));
  }
}
