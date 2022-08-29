import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/task.dart';

import '../date_utils.dart';

class MyDatabase {

  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (documentSnapShot, snapShotOptions) {
          return Task.fromFireStore(documentSnapShot.data()!);
        },
        toFirestore: (task, options) {
          return task.toFireStore();
        });
  }

  // to add new task
  static Future<void> addNewTask(Task task) {
    var tasksCollection = getTasksCollection(); // to get Collection from db
    var taskDocument = tasksCollection
        .doc(); // to create new Document in this Collection
    task.id = taskDocument.id;
    return taskDocument.set(task); // to set Data from class to document
  }

  // to delete task
  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(
        task.id); //to get collection from db then get document with specific id
    return taskDoc.delete(); // to delete this document
  }

  // get all tasks and build List (read data once)
  static Future<QuerySnapshot<Task>> getAllTasks(DateTime selectedDate) async {
    // read data only once
    return await getTasksCollection()
        .where(
        'dateTime', isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
  }

  // get all task one by one and build List (listen date for realtime)
  static Stream<QuerySnapshot<Task>> listenForTaskRealTimeUpdates(
      DateTime selectedDate) {
    // listen for realtime updates
    return getTasksCollection()
        .where(
        'dateTime', isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .snapshots();
  }

  // to edit a task
  static void editTaskIsDone(Task task) {
    var taskCollection = getTasksCollection();  // get this collection (Table)
    var taskDoc = taskCollection.doc(task.id).update(  // get this doc from this collection (row in this table) with id then update
        {
          'isDone': (task.isDone!)? false:true
        });
  }

  // to update a task
  static Future<void> editTaskDetails(Task task){
    var taskCollection = getTasksCollection();  // get this collection (Table)
    return  taskCollection.doc(task.id).update({
      'title':task.title,
      'description': task.description,
      'dateTime':dateOnly(task.dateTime!).millisecondsSinceEpoch
    });

  }
}
