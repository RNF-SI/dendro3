class SimpleElement {
  List<MapEntry<String, dynamic>> _entries;

  SimpleElement([List<MapEntry<String, dynamic>>? entries])
      : _entries = entries ?? [];

  // Getter to return the list of MapEntries
  List<MapEntry<String, dynamic>> get entries => _entries;

  // Setter to modify the list of MapEntries
  set entries(List<MapEntry<String, dynamic>> value) {
    _entries = value;
  }

  // Method to check if a specific key exists
  bool containsKey(String key) {
    for (var entry in _entries) {
      if (entry.key == key) {
        return true;
      }
    }
    return false;
  }

  // Method to get a value by key
  int? getValue(String key) {
    for (var entry in _entries) {
      if (entry.key == key) {
        return entry.value;
      }
    }
    return null; // Return null if key is not found
  }

  // Method to set a value by key
  void setValue(String key, int value) {
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].key == key) {
        _entries[i] = MapEntry(key, value); // Update if key exists
        return;
      }
    }
    _entries.add(MapEntry(key, value)); // Add new entry if key does not exist
  }

  // Method to add a new entry at the next index
  void addEntry(String key, dynamic value) {
    _entries.add(MapEntry(key, value)); // Adds at the end of the list
  }

  // Method to remove entries based on a condition
  void removeWhere(bool Function(MapEntry<String, dynamic>) test) {
    _entries.removeWhere(test);
  }

  // Method to transform each entry in the list
  List<R> map<R>(R Function(MapEntry<String, dynamic>) transform) {
    return _entries.map(transform).toList();
  }

  // Getter to get the number of entries
  int get length => _entries.length;
}
