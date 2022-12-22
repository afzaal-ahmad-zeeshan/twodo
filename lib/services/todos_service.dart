import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:twodo/models/todo.dart';

class TodosService {
  static const String collectionName = "twodos";

  Future<bool> addTodo(Todo todo) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection(collectionName)
          .withConverter<Todo>(
            fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
            toFirestore: (todo, _) => todo.toJson(),
          );

      await ref.add(todo);
      debugPrint("Added the todo.");
    } catch (e) {
      debugPrint("Could not add the todo");
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<Todo?> findTodo(bool favorite) async {
    Todo todo;
    try {
      var todos = FirebaseFirestore.instance.collection(collectionName);
      var query = await todos.where("favorite", isEqualTo: favorite).get();

      // await ref.add(todo);
      var docId = query.docs.first.id;
      var data = (await todos.doc(docId).get()).data();

      todo = Todo.fromJson(data!);
      debugPrint(data.toString());
      return todo;
    } catch (e) {
      debugPrint("Could not find the todo");
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Todo>?> getTodos() async {
    try {
      var todos = FirebaseFirestore.instance.collection(collectionName);
      var query = await todos.where("favorite", isEqualTo: true).get();

      // await ref.add(todo);
      var data = query.docs.map((item) => Todo.fromJson(item.data())).toList();
      debugPrint(data.toString());

      return null;
    } catch (e) {
      debugPrint("Could not find the todos");
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> updateTodo(String id, Todo todo) async {
    try {
      var todos = FirebaseFirestore.instance.collection(collectionName);
      var query = await todos.where("id", isEqualTo: id).get();

      // await ref.add(todo);
      await todos.doc(query.docs.first.id).update({
        "id": todo.id,
        "title": todo.title,
        "favorite": todo.favorite,
        "order": todo.order,
        "owners": todo.owners,
        "colorAccent": todo.colorAccent,
        "deleteWhenDone": todo.deleteWhenDone,
      });
      debugPrint("Updated the document.");
    } catch (e) {
      debugPrint("Could not update the todo");
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> deleteTodo(String id) async {
    try {
      var todos = FirebaseFirestore.instance.collection(collectionName);
      var query = await todos.where("id", isEqualTo: id).get();

      // await ref.add(todo);
      await todos.doc(query.docs.first.id).delete();
      debugPrint("Deleted the document.");
    } catch (e) {
      debugPrint("Could not delete the todo");
      debugPrint(e.toString());
      return false;
    }
    return true;
  }
}
