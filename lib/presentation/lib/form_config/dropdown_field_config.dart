import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownFieldConfig<T> extends FieldConfig {
  final List<MapEntry<String, String>> items;
  final T value;

  static String? defaultValidator(
      dynamic value, Map<String, dynamic> formData) {
    return null;
  }

  final String? Function(dynamic, Map<String, dynamic>)? validator;

  final void Function(T)? onChanged;

  DropdownFieldConfig({
    required String fieldName,
    fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    required this.items,
    required this.value,
    String? Function(dynamic, Map<String, dynamic>)? validator,
    this.onChanged,
    final bool Function(Map<String, dynamic>)? isVisibleFn,
  })  : validator = validator ?? defaultValidator,
        super(
            fieldName: fieldName,
            fieldRequired: fieldRequired,
            fieldUnit: fieldUnit,
            fieldInfo: fieldInfo,
            isVisibleFn: isVisibleFn);
}
