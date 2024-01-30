import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseListViewModel<T> extends StateNotifier<T> {
  BaseListViewModel(T state) : super(state);
  Future<void> addItem(Map item);
  Future<void> updateItem(Map item, {Arbre? arbre, BmSup30? bmSup30});
  Future<void> deleteItem(String id);
  // Future<void> updateItem(Object item);
  // add any other operations you need
}
