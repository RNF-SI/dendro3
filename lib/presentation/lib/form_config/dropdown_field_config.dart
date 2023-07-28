import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownFieldConfig<T> extends FieldConfig {
  final List<String> items;
  final T value;
  final String? Function(Object?)? validator;

  final void Function(T)? onChanged;

  DropdownFieldConfig({
    required String fieldName,
    fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    required this.items,
    required this.value,
    this.validator,
    this.onChanged,
  }) : super(
            fieldName: fieldName,
            fieldRequired: fieldRequired,
            fieldUnit: fieldUnit,
            fieldInfo: fieldInfo);
}
