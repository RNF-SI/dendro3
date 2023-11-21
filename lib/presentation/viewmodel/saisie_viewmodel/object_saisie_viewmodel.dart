import 'package:dendro3/presentation/lib/form_config/field_config.dart';

abstract class ObjectSaisieViewModel {
  // late final BaseListViewModel _baseListViewModel;
  // var _isNewObject = false;

  // ObjectSaisieViewModel(this._baseListViewModel) {
  //   fetchData();
  // }
  Future<void> createObject();
  Future<void> updateObject();

  List<FieldConfig> getFormConfig();
  // // Methods that can be overridden by subclasses if required
  // void initData(final object) {}
  // Future<void> fetchData() async {}

  // // Common method that could be used by all subclasses
  // Future<void> createOrUpdateObject() async {
  //   if (_isNewObject) {
  //     _baseListViewModel.addItem({
  //       // You can set common attributes here
  //       // and more specific attributes in the subclass
  //     });
  //   } else {
  //     // Handle update of an existing object
  //     // It might be necessary to handle this in the subclass depending on the attributes of the subclass
  //   }
  // }

  // bool shouldShowDeleteObjectIcon() => !_isNewObject;
}
