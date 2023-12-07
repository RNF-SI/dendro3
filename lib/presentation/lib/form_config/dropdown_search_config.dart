import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownSearchConfig<T> extends FieldConfig {
  final Future<List<T>> Function(String, [Map<String, dynamic>?]) asyncItems;
  final bool isMultiSelection;
  final T? Function()? selectedItem;
  final List<T> Function()? selectedItems;
  final bool Function(T, String) filterFn;
  final String Function(T)? itemAsString;
  final void Function(T)? onChanged;

  static String? defaultValidator(
      dynamic value, Map<String, dynamic> formData) {
    // Votre logique de validation par défaut
    return null;
  }

  Future<List<dynamic>>? defaultFutureVariable;

  String? Function(dynamic, Map<String, dynamic>) validator;

  Future<List<dynamic>>? futureVariable;

  DropdownSearchConfig({
    required String fieldName,
    bool fieldRequired = false,
    String fieldUnit = '',
    String fieldInfo = '',
    // required this.items,
    required this.asyncItems,
    this.isMultiSelection = false,
    // this.selectedItems,
    this.itemAsString,
    String? Function(dynamic, Map<String, dynamic>)? validator,
    Future<List<dynamic>>? futureVariable,
    T? Function()? selectedItem,
    List<T> Function()? selectedItems,
    this.onChanged,
    required this.filterFn,
    final bool Function(Map<String, dynamic>)? isVisibleFn,
  })  : validator = validator ?? defaultValidator,
        futureVariable = futureVariable ?? Future.value([]),
        selectedItem = selectedItem ?? (() => null),
        selectedItems = selectedItems ?? (() => []),
        super(
          fieldName: fieldName,
          fieldRequired: fieldRequired,
          fieldUnit: fieldUnit,
          fieldInfo: fieldInfo,
          isVisibleFn: isVisibleFn,
        );
}
