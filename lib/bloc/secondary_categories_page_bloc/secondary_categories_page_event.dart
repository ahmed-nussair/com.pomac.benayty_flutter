import 'package:meta/meta.dart';

@immutable
abstract class SecondaryCategoriesPageEvent {}

class SelectSecondaryItemEvent extends SecondaryCategoriesPageEvent {}

class SelectAreaEvent extends SecondaryCategoriesPageEvent {}

class SelectAreaAndCityEvent extends SecondaryCategoriesPageEvent {}

class SelectSecondaryItemAndAreaEvent extends SecondaryCategoriesPageEvent {}

class SelectSecondaryItemAndAreaAndCityEvent extends SecondaryCategoriesPageEvent {}

class SelectCityEvent extends SecondaryCategoriesPageEvent {}
