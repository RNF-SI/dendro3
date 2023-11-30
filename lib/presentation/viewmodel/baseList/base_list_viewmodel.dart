import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:dendro3/presentation/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseListViewModel<T> extends StateNotifier<T> {
  BaseListViewModel(T state) : super(state);
  Future<void> addItem(Map item);
  Future<void> updateItem(Map item, {Arbre? arbre, BmSup30? bmSup30});
  // Future<void> updateItem(Object item);
  // add any other operations you need
}
