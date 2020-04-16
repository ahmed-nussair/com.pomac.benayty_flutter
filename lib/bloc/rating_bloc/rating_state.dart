import 'package:meta/meta.dart';

@immutable
abstract class RatingState {}

class InitialRatingState extends RatingState {}

class OneStarState extends RatingState {}

class TwoStarState extends RatingState {}

class ThreeStarState extends RatingState {}

class FourStarState extends RatingState {}

class FiveStarState extends RatingState {}
