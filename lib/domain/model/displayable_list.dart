// List that can be displayed in the SaisieDataTable Component
import 'package:dendro3/core/types/saisie_data_table_types.dart';

abstract class DisplayableList {
  List<Map<String, dynamic>> getObjectMapped({
    DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  });

  getObjectFromId(final String id);

  getFirstElementId();

  bool isEmpty();
}

// Concrete implementation of DisplayableList representing an empty list.
class EmptyDisplayableList extends DisplayableList {
  @override
  List<Map<String, dynamic>> getObjectMapped({
    DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return []; // Returns an empty list.
  }

  @override
  getObjectFromId(final String id) {
    // Return null or an appropriate default object.
    return null;
  }

  @override
  getFirstElementId() {
    // Return null or an appropriate default value.
    return null;
  }

  @override
  bool isEmpty() {
    return true; // Always returns true for the empty list.
  }
}
