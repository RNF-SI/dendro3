import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DateFieldConfig extends FieldConfig {
  final DateTime initialValue;
  final void Function(DateTime) onDateSelected;

  DateFieldConfig({
    required this.initialValue,
    required String fieldName,
    fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    required this.onDateSelected,
    final bool Function(Map<String, dynamic>)? isVisibleFn,
    final String? importantMessage,
  }) : super(
          fieldName: fieldName,
          fieldRequired: fieldRequired,
          fieldUnit: fieldUnit,
          fieldInfo: fieldInfo,
          isVisibleFn: isVisibleFn,
          importantMessage: importantMessage,
        );
}
