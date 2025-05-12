import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';

class FirebaseTodoDataSource {
  final FirebaseFirestore firestore;

  FirebaseTodoDataSource(this.firestore);

  Future<void> create(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).set(todo.toJson());
  }

  Future<List<TodoModel>> fetchAll() async {
    final snapshot = await firestore.collection('todos').get();
    return snapshot.docs.map((doc) => TodoModel.fromJson(doc.data())).toList();
  }

  Future<void> update(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  Future<void> delete(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}
