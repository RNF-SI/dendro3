import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldConfig extends FieldConfig {
  final String initialValue;
  final bool isEditable;

  // Fonction de validation par défaut
  static String? defaultValidator(
      String? value, Map<String, dynamic> formData) {
    // Votre logique de validation par défaut
    return null;
  }

  // Définir la fonction de validation avec la valeur par défaut
  String? Function(String?, Map<String, dynamic>) validator;

  final TextInputType? keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  // final InputDecoration? decoration;
  final String hintText;
  final void Function(String)? onChanged;

  TextFieldConfig({
    required String fieldName,
    bool fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    required this.initialValue,
    this.isEditable = true,
    String? Function(String?, Map<String, dynamic>)? validator,
    this.keyboardType,
    this.maxLines,
    this.inputFormatters,
    // this.decoration,
    required this.hintText,
    this.onChanged,
    final bool Function(Map<String, dynamic>)? isVisibleFn,
  })  : validator = validator ?? defaultValidator,
        super(
          fieldName: fieldName,
          fieldRequired: fieldRequired,
          fieldUnit: fieldUnit,
          fieldInfo: fieldInfo,
          isVisibleFn: isVisibleFn,
        );
}
