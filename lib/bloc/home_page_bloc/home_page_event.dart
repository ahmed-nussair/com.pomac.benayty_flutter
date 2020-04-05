import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class NavigateToHomePageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToSecondaryPageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToWishListPageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToNotificationsPageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToMessagesPageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToSearchPageEvent extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToAdvertiseAddingPage1 extends HomePageEvent{
  @override
  List<Object> get props => [];
}

class NavigateToAdvertiseAddingPage2 extends HomePageEvent{
  @override
  List<Object> get props => [];
}
