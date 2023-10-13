import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/UserDao.dart';
import 'package:todo_app/database/model/Task.dart';

class TasksDao {
  static CollectionReference<Task> getTasksCollection(String uid) {
    return UserDoa.getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> createTask(Task task, String uid) {
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> updateTask(Task task, String uid) async {
    var docRef = await getTasksCollection(uid).doc(task.id);

    var updated = {
      'title': task.title,
      'description': task.description,
      'datetime' : task.datetime
    };

    await docRef.update(updated);
  }

  static Future<List<Task>> getAllTasks(String uid,
      DateTime selectedDay) async {

    var tasksSnapShot = await getTasksCollection(uid).where("datetime",
        isEqualTo: Timestamp.fromMillisecondsSinceEpoch(
            DateUtils.dateOnly(selectedDay).millisecondsSinceEpoch)).get();

    var tasksList =
    tasksSnapShot.docs.map((snapshot) => snapshot.data()).toList();

    return tasksList;
  }

  static Stream<List<Task>> listenForTasks(String uid , DateTime selectedDay) async* {

    var stream = getTasksCollection(uid).where("datetime",
        isEqualTo: Timestamp.fromMillisecondsSinceEpoch(
            DateUtils.dateOnly(selectedDay).millisecondsSinceEpoch)).snapshots();
    yield* stream.map((querySnapshot) =>
        querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  static Future<void> removeTask(String taskid, String uid) {
    return getTasksCollection(uid).doc(taskid).delete();
  }

  static Future<void> finishTask(String taskid, String uid) {
    return getTasksCollection(uid).doc(taskid).update({'isDone': true});
  }
}
