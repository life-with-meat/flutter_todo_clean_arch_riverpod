import 'package:flutter/material.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/widget/app_text_field.dart';

/// Todoの作成・編集用ダイアログ
class InputDialog extends StatefulWidget {
  final String initialValue;
  final String dialogTitle;
  final int? maxLength;
  final String? Function(String value) validator;
  final void Function(String value) onSubmit;

  const InputDialog({
    super.key,
    required this.initialValue,
    required this.dialogTitle,
    required this.validator,
    required this.onSubmit,
    this.maxLength,
  });

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _textFieldKey = GlobalKey<AppTextFieldState>();
  String _value = '';

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleSave() {
    _textFieldKey.currentState?.validateExternally();

    final error = widget.validator(_value);
    if (error == null) {
      widget.onSubmit(_value.trim());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            key: _textFieldKey,
            initialValue: widget.initialValue,
            label: '入力内容',
            validator: widget.validator,
            maxLength: widget.maxLength,
            onChanged: (v) => _value = v,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(onPressed: _handleSave, child: const Text('保存')),
      ],
    );
  }
}
