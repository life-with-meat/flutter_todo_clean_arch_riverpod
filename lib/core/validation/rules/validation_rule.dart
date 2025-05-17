abstract class ValidationRule {
  String? validate(String value);
  String get errorMessage;
}
