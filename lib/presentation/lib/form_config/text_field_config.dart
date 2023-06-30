import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldConfig extends FieldConfig {
  final String initialValue;
  final bool isEditable;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  // final InputDecoration? decoration;
  final String hintText;
  final void Function(String)? onChanged;

  TextFieldConfig({
    required String fieldName,
    required this.initialValue,
    this.isEditable = true,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.inputFormatters,
    // this.decoration,
    required this.hintText,
    this.onChanged,
  }) : super(fieldName: fieldName);
}
