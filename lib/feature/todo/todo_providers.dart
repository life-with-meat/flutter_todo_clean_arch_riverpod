import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/application/todo_usecases.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/infrastructure/data_source/firebase_todo_data_source.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/infrastructure/todo_repository_impl.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final dataSource = FirebaseTodoDataSource(firestore);
  return TodoRepositoryImpl(dataSource);
});

final todoUsecaseProvider = Provider((ref) {
  return TodoUsecases(ref.watch(todoRepositoryProvider));
});
