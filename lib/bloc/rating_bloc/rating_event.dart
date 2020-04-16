import 'package:meta/meta.dart';

@immutable
abstract class RatingEvent {}

class GiveOneStarEvent extends RatingEvent {}

class GiveTwoStarEvent extends RatingEvent {}

class GiveThreeStarEvent extends RatingEvent {}

class GiveFourStarEvent extends RatingEvent {}

class GiveFiveStarEvent extends RatingEvent {}
