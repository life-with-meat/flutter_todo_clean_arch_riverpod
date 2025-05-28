import 'package:flutter/material.dart';

/// 汎用バリデーション対応のテキストフィールド
class AppTextField extends StatefulWidget {
  final String initialValue;
  final String label;
  final ValueChanged<String> onChanged;
  final String? Function(String)? validator;
  final bool showCounter;
  final int? maxLength;

  const AppTextField({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    this.validator,
    this.showCounter = true,
    this.maxLength,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  String _currentValue = '';
  String? _errorText;

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
      _errorText = widget.validator?.call(value);
    });

    if (_errorText == null) {
      widget.onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLength = _currentValue.length;
    final isOverMax =
        widget.maxLength != null && currentLength > widget.maxLength!;
    final showLengthCounter = widget.showCounter && widget.maxLength != null;

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: _errorText,
        helperText:
            showLengthCounter ? '$currentLength/${widget.maxLength}' : null,
        helperStyle: TextStyle(color: isOverMax ? Colors.red : null),
      ),
      onChanged: _validateAndUpdate,
      maxLength: widget.maxLength,
      buildCounter:
          widget.showCounter
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
