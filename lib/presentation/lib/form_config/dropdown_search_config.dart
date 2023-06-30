import 'package:dendro3/presentation/lib/form_config/field_config.dart';

class DropdownSearchConfig<T> extends FieldConfig {
  final Future<List<T>> Function(String) asyncItems;
  final T? selectedItem;
  final bool Function(T, String) filterFn;
  final String Function(T)? itemAsString;
  final void Function(T)? onChanged;

  DropdownSearchConfig({
    required String fieldName,
    // required this.items,
    required this.asyncItems,
    this.selectedItem,
    this.itemAsString,
    this.onChanged,
    required this.filterFn,
  }) : super(fieldName: fieldName);
}
