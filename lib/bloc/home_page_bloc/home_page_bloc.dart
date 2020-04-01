import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  @override
  HomePageState get initialState => InitialHomePageState();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if(event is NavigateToHomePageEvent){
      yield MainPageState();
    } else if (event is NavigateToWishListPageEvent){
      yield WishListPageState();
    } else if (event is NavigateToNotificationsPageEvent){
      yield NotificationsPageState();
    } else if (event is NavigateToMessagesPageEvent){
      yield MessagesPageState();
    } else if (event is NavigateToSearchPageEvent){
      yield SearchPageState();
    } else {
      yield InitialHomePageState();
    }
  }
}
