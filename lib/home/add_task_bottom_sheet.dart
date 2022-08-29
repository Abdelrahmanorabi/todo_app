import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';

import '../date_utils.dart';
import '../dialogeUtils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  /*======================[Variables]=========================*/

  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  /*===========================================================*/

  /*======================[Methods]=========================*/
  void addTask() {
    if (formKey.currentState?.validate() == true) {
      String title = titleController.text;
      String description = descriptionController.text;
      Task task = Task(
          title: title,
          description: description,
          dateTime: dateOnly(selectedDate),
          isDone: false);
      showLoading(context, 'Loading.........', isCancelable: false);
      MyDatabase.addNewTask(task).then((value) {
        // called when future function is completed  successfully
        hideLoading(context);
        showMessage(
          context,
          'Task Added Successfully',
          posActionName: 'OK',
          posAction: () {
            Navigator.pop(context);
          },
        );
      }).onError((error, stackTrace) {
        // called when future fails or has error
        hideLoading(context);
        showMessage(context, 'something went wrong,try again later');
      }).timeout(
          // called after time if there is no internet and save date locally (cash)
          const Duration(seconds: 2), onTimeout: () {
        hideLoading(context);
        showMessage(context, 'Task Added locally', posActionName: 'OK',
            posAction: () {
          Navigator.pop(context);
        });
      });
    }
  }

  void showDateDialog() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }

  /*===========================================================*/

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          .70, // to set bottomSheet specific height
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please Entre title';
                }
                return null;
              },
              style: Theme.of(context).textTheme.titleMedium,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please Entre description';
                }
                return null;
              },
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 3,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            InkWell(
              onTap: () {
                showDateDialog();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Date',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                    const Icon(
                      Icons.date_range_outlined,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                DateFormat('yyyy-MM-dd').format(selectedDate),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: Text(
                'Submit',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
