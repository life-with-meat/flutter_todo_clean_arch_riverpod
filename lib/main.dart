import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //追加
  await Firebase.initializeApp(); // 追加（Firebaseの初期化）

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoPage());
  }
}
