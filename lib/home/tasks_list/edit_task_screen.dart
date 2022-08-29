import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/my_theme.dart';

import '../../database/task.dart';

class EditTaskScreen extends StatefulWidget {
  /*========================[Variables]========================*/
  static const String routeName = 'edit-task';
  Task task;

  /*============================================================*/

  // constructor
  EditTaskScreen(this.task);

  // constructor
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  /*========================[Variables]========================*/
  DateTime selectedDate = DateTime.now();
  DateTime newDate =DateTime.now();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  /*============================================================*/

  /*========================[Methods]========================*/
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



  void editTask(){
    if(formKey.currentState?.validate() == true){
      MyDatabase.editTaskDetails(widget.task).then((value) {
        Navigator.pop(context);
      });

    }

  }
  /*============================================================*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .2,
              color: MyTheme.lightPrimary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'ToDo List',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height * .80,
              padding: const EdgeInsets.only(
                  top: 30, left: 30, right: 30, bottom: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Edit Task',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      initialValue: widget.task.title,
                      onChanged:(String? value){
                        widget.task.title = value;
                      },
                      validator: ( value){
                        if (value == null || value.trim().isEmpty) {
                          return 'title filed is required ';
                        }
                        return null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      onChanged: (String? value){
                          widget.task.description = value;
                      },
                      validator: ( value){
                        if (value == null || value.trim().isEmpty) {
                          return 'description filed is required ';
                        }
                        return null;
                      },
                      initialValue: widget.task.description,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black, fontSize: 18),
                      decoration: const InputDecoration(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        showDateDialog();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                          const Icon(
                            Icons.date_range_outlined,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task date:',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          (selectedDate == widget.task.dateTime)? DateFormat('yyyy-MM-dd').format(widget.task.dateTime!) : DateFormat('yyyy-MM-dd').format(selectedDate),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: MyTheme.lightPrimary,
                                    fontSize: 18,
                                  ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    MaterialButton(
                      minWidth: 255,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        editTask();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'Save Changes',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Icon(
                              Icons.save,
                              color: Colors.white,
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

//DateFormat('yyyy-MM-dd').format(widget.task.dateTime!)