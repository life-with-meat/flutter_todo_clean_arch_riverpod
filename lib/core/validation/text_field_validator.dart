import 'package:flutter_todo_clean_arch_riverpod/core/validation/rules/length_rule.dart';
import 'package:flutter_todo_clean_arch_riverpod/core/validation/rules/required_rule.dart';
import 'package:flutter_todo_clean_arch_riverpod/core/validation/validator.dart';

class TextFieldValidator extends Validator<String> {
  TextFieldValidator({int? maxLength, int? minLength, bool required = true})
    : super([
        if (required) RequiredRule(),
        if (maxLength != null || minLength != null)
          LengthRule(maxLength: maxLength, minLength: minLength),
      ]);

  int? get maxLength => getRule<LengthRule>()?.maxLength;
  int? get minLength => getRule<LengthRule>()?.minLength;

  @override
  String? validate(String value) {
    final trimmed = value.trim();
    return super.validate(trimmed);
  }
}
