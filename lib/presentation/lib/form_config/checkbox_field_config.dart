import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';

class CheckboxFieldConfig extends FieldConfig {
  final bool initialValue;
  final FormFieldSetter<bool> onSaved;

  CheckboxFieldConfig({
    required String fieldName,
    required this.initialValue,
    required this.onSaved,
  }) : super(fieldName: fieldName);
}
