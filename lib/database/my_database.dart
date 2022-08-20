import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/task.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollections() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: (documentSnapShot, option) {
      return Task.fromFireStore(documentSnapShot.data()!);
    }, toFirestore: (task, option) {
      return task.toFireStore();
    });
  }

  static void insertTask(Task task) {
    var tasksCollections = getTasksCollections();
    var taskDocument = tasksCollections.doc(); // to create new Doc

    task.id = taskDocument.id;
    taskDocument.set(task);
  }

}
