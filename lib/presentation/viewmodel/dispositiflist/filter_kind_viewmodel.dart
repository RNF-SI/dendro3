import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterKind { all, downloaded, undownloaded }

final filterKindViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<FilterKindViewModel, FilterKind>((_) => FilterKindViewModel());

class FilterKindViewModel extends StateNotifier<FilterKind> {
  FilterKindViewModel() : super(FilterKind.all);

  filterByAll() => state = FilterKind.all;

  filterByDownloaded() => state = FilterKind.downloaded;

  filterByUndownloaded() => state = FilterKind.undownloaded;

  bool isFilteredByAll() => state == FilterKind.all;

  bool isFilteredByDownloaded() => state == FilterKind.downloaded;

  bool isFilteredByUndownloaded() => state == FilterKind.undownloaded;
}
