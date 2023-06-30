import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';

class DateFieldConfig extends FieldConfig {
  final void Function(DateTime) onDateSelected;

  DateFieldConfig({
    required String fieldName,
    required this.onDateSelected,
  }) : super(fieldName: fieldName);
}
