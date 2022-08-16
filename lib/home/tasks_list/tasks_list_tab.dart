import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/tasks_list/task_widget.dart';
import 'package:todo_app/providers/settings_provider.dart';

class TasksListTab extends StatelessWidget {

  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
        child:Column(
          children: [
            CalendarTimeline(
              showYears: true,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: settingsProvider.isDark()? Colors.white:Colors.black,
              dayColor: settingsProvider.isDark()? Colors.white:Colors.black,
              activeDayColor: Theme.of(context).primaryColor,
              activeBackgroundDayColor: Colors.white,
              dotsColor:Theme.of(context).primaryColor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
            Expanded(
                child: ListView.builder(
                    // itemCount: ,
                    itemBuilder: (context,index){
                      return TaskWidget();
                    }))
          ],
        )
    );
  }
}
