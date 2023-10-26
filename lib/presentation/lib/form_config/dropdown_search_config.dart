import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownSearchConfig<T> extends FieldConfig {
  final Future<List<T>> Function(String) asyncItems;
  final T? selectedItem;
  final bool Function(T, String) filterFn;
  final String Function(T)? itemAsString;
  final void Function(T)? onChanged;
  final String? Function(dynamic)? validator;

  DropdownSearchConfig(
      {required String fieldName,
      bool fieldRequired = false,
      String fieldUnit = '',
      String fieldInfo = '',
      // required this.items,
      required this.asyncItems,
      this.selectedItem,
      this.itemAsString,
      this.validator,
      this.onChanged,
      required this.filterFn,
      final bool Function(Map<String, dynamic>)? isVisibleFn})
      : super(
            fieldName: fieldName,
            fieldRequired: fieldRequired,
            fieldUnit: fieldUnit,
            fieldInfo: fieldInfo,
            isVisibleFn: isVisibleFn);
}
