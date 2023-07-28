abstract class FieldConfig {
  final String fieldName;
  final bool fieldRequired;
  final String fieldUnit;

  FieldConfig(
      {required this.fieldName,
      required this.fieldRequired,
      required this.fieldUnit});
}
