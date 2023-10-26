import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';

class DateFieldConfig extends FieldConfig {
  final void Function(DateTime) onDateSelected;

  DateFieldConfig(
      {required String fieldName,
      fieldRequired = false,
      String fieldUnit = '',
      String fieldInfo = '',
      required this.onDateSelected,
      final bool Function(Map<String, dynamic>)? isVisibleFn})
      : super(
            fieldName: fieldName,
            fieldRequired: fieldRequired,
            fieldUnit: fieldUnit,
            fieldInfo: fieldInfo,
            isVisibleFn: isVisibleFn);
}
