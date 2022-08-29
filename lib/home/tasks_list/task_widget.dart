import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/dialogeUtils.dart';
import 'package:todo_app/home/tasks_list/edit_task_screen.dart';
import 'package:todo_app/providers/settings_provider.dart';

import '../../database/task.dart';
import '../../my_theme.dart';
import '../../providers/task_provider.dart';

class TaskWidget extends StatelessWidget {
  /*====================[Variables]====================*/
  late SettingsProvider settingsProvider;
  Task task;
  late TaskProvider provider;

  /*==================================================*/
  // Constructor
  TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                MyDatabase.deleteTask(task).then((value) {
                  showMessage(context, 'Task Deleted successfully',
                      posActionName: 'ok', posAction: () {
                    Navigator.pop(context);
                  });
                }).onError((error, stackTrace) {
                  showMessage(context, 'something went wrong,please try again');
                }).timeout(const Duration(seconds: 5), onTimeout: () {
                  showMessage(context, 'Data Deleted locally',
                      posActionName: 'ok', posAction: () {
                    Navigator.pop(context);
                  });
                });
              },
              icon: Icons.delete,
              backgroundColor: MyTheme.red,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            )
          ],
        ),
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
          decoration: BoxDecoration(
            color: settingsProvider.isDark()
                ? const Color(0xFF141922)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: (task.isDone!)
                        ? MyTheme.green
                        : Theme.of(context).primaryColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: (task.isDone!)
                              ? MyTheme.green
                              : Theme.of(context).primaryColor),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: settingsProvider.isDark()
                              ? Colors.white
                              : Colors.black,
                        ),
                        Text(
                          '10:00 AM',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: settingsProvider.isDark()
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 35,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              task.description ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: settingsProvider.isDark()
                                          ? Colors.white
                                          : Colors.black),
                              maxLines: 12,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      MyDatabase.editTaskIsDone(task);
                    },
                    child: (task.isDone!)
                        ? Text('Done ✔️',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: MyTheme.green))
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MyTheme.lightPrimary),
                            child: Text(
                              '❌',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditTaskScreen(task)));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
