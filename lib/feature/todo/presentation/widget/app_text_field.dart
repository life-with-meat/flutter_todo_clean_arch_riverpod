import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/core/validation/text_field_validator.dart';

/// バリデーション機能付きのテキストフィールド
class AppTextField extends ConsumerStatefulWidget {
  /// 初期値
  final String initialValue;

  /// ラベルテキスト
  final String label;

  /// エラー状態を管理するプロバイダー
  final StateProvider<String?> errorProvider;

  /// 値が変更された時のコールバック
  final ValueChanged<String> onChanged;

  /// バリデーター
  final TextFieldValidator validator;

  /// 文字数カウンターを表示するかどうか
  final bool showCounter;

  const AppTextField({
    super.key,
    required this.initialValue,
    required this.label,
    required this.errorProvider,
    required this.onChanged,
    required this.validator,
    this.showCounter = true,
  });

  @override
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField> {
  late final TextEditingController _controller;
  String _currentValue = '';

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndUpdate(String value) {
    setState(() {
      _currentValue = value;
    });

    final error = widget.validator.validate(value);
    ref.read(widget.errorProvider.notifier).state = error;

    if (error == null) {
      widget.onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final showCounter = widget.showCounter;
    final maxLength = widget.validator.maxLength;
    final currentLength = _currentValue.length;
    final isOverMaxLength = maxLength != null && currentLength > maxLength;
    final errorText = ref.watch(widget.errorProvider);
    final showLengthCounter = showCounter && maxLength != null;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: errorText,
        helperText: showLengthCounter ? '$currentLength/$maxLength' : null,
        helperStyle: TextStyle(color: isOverMaxLength ? Colors.red : null),
      ),
      onChanged: _validateAndUpdate,
      maxLength: maxLength,
      buildCounter:
          showCounter
              ? null
              : (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) => null,
    );
  }
}
