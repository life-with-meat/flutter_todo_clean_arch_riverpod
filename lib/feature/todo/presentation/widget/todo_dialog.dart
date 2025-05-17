import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/widget/app_text_field.dart';

/// Todoの作成・編集用ダイアログ
class TodoDialog extends ConsumerWidget {
  final String initialTitle;
  final String dialogTitle;
  final Function(String) onSave;
  final StateProvider<String?> errorProvider;

  const TodoDialog({
    super.key,
    required this.initialTitle,
    required this.dialogTitle,
    required this.onSave,
    required this.errorProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String editedTitle = initialTitle;
    return AlertDialog(
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            initialValue: initialTitle,
            label: 'タスク名',
            errorProvider: errorProvider,
            validator: TodoTitle.validator,
            onChanged: (value) {
              editedTitle = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(errorProvider.notifier).state = null;
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            try {
              // 値オブジェクトの作成（バリデーションを含む）
              TodoTitle(editedTitle);
              onSave(editedTitle.trim());
              ref.read(errorProvider.notifier).state = null;
              Navigator.of(context).pop();
            } on ArgumentError catch (e) {
              ref.read(errorProvider.notifier).state = e.message;
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
