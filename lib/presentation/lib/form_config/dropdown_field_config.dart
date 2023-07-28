import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownFieldConfig<T> extends FieldConfig {
  final List<String> items;
  final T value;
  final void Function(T)? onChanged;

  DropdownFieldConfig({
    required String fieldName,
    fieldRequired = false,
    String fieldUnit = '',
    required this.items,
    required this.value,
    this.onChanged,
  }) : super(
            fieldName: fieldName,
            fieldRequired: fieldRequired,
            fieldUnit: fieldUnit);
}
