abstract class FieldConfig {
  final String fieldName;
  final bool fieldRequired;
  final String fieldUnit;
  final String fieldInfo;
  // final bool isVisible;
  // Function returning a bool and taking an array of values as an argument
  final bool Function(Map<String, dynamic>)? isVisibleFn;
  // final bool Function(String?)? isVisibleFn;

  FieldConfig(
      {required this.fieldName,
      required this.fieldRequired,
      required this.fieldUnit,
      required this.fieldInfo,
      required this.isVisibleFn});
}
