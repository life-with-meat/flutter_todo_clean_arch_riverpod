import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';

class FirebaseTodoDataSource {
  final FirebaseFirestore firestore;

  FirebaseTodoDataSource(this.firestore);

  Future<void> create(TodoModel todo) async {
    try {
      await firestore.collection('todos').doc(todo.id).set(todo.toJson());
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<List<TodoModel>> fetchAll() async {
    try {
      final snapshot = await firestore.collection('todos').get();
      return snapshot.docs
          .map((doc) => TodoModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<void> update(TodoModel todo) async {
    try {
      await firestore.collection('todos').doc(todo.id).update(todo.toJson());
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection('todos').doc(id).delete();
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
}
