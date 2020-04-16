import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  @override
  RatingState get initialState => InitialRatingState();

  @override
  Stream<RatingState> mapEventToState(RatingEvent event,) async* {
    yield InitialRatingState();

    if (event is GiveOneStarEvent) {
      yield OneStarState();
    } else if (event is GiveTwoStarEvent) {
      yield TwoStarState();
    } else if (event is GiveThreeStarEvent) {
      yield ThreeStarState();
    } else if (event is GiveFourStarEvent) {
      yield FourStarState();
    } else if (event is GiveFiveStarEvent) {
      yield FiveStarState();
    }
  }
}
