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
    } else if (event is NavigateToSecondaryPageEvent){
      yield SecondaryPageState();
    } else if (event is NavigateToNotificationsPageEvent){
      yield NotificationsPageState();
    } else if (event is NavigateToMessagesPageEvent){
      yield MessagesPageState();
    } else if (event is NavigateToSearchPageEvent){
      yield SearchPageState();
    } else if (event is NavigateToAdvertiseAddingPage1){
      yield AddAdvertisementPage1State();
    } else if (event is NavigateToAdvertiseAddingPage2){
      yield AddAdvertisementPage2State();
    } else if (event is NavigateToAdDescription) {
      yield AdDescriptionState();
    } else if (event is NavigateToChattingPageEvent) {
      yield ChattingPageState();
    } else if (event is NavigateToContactUsPage) {
      yield ContactUsState();
    } else {
      yield InitialHomePageState();
    }
  }
}
