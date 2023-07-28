abstract class FieldConfig {
  final String fieldName;
  final bool fieldRequired;
  final String fieldUnit;
  final String fieldInfo;

  FieldConfig(
      {required this.fieldName,
      required this.fieldRequired,
      required this.fieldUnit,
      required this.fieldInfo});
}
