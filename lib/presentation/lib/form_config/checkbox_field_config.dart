import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';

class CheckboxFieldConfig extends FieldConfig {
  final bool initialValue;
  final FormFieldSetter<bool> onSaved;

  CheckboxFieldConfig({
    required String fieldName,
    bool fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    required this.initialValue,
    required this.onSaved,
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
