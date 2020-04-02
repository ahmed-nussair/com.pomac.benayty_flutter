import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SecondaryCategoriesPageBloc extends Bloc<SecondaryCategoriesPageEvent, SecondaryCategoriesPageState> {
  @override
  SecondaryCategoriesPageState get initialState => InitialSecondaryCategoriesPageState();

  @override
  Stream<SecondaryCategoriesPageState> mapEventToState(
    SecondaryCategoriesPageEvent event,
  ) async* {
    yield InitialSecondaryCategoriesPageState();

    if(event is SelectSecondaryItemEvent){
      yield SecondaryItemSelectedState();
    }else if (event is SelectAreaEvent){
      yield AreaSelectedState();
    }else if(event is SelectCityEvent){
      yield CitySelectedState();
    } else if(event is SelectSecondaryItemAndAreaEvent){
      yield SecondaryItemAndAreaSelectedState();
    } else if(event is SelectAreaAndCityEvent){
      yield AreaAndCitySelectedState();
    } else if(event is SelectSecondaryItemAndAreaAndCityEvent){
      yield SecondaryItemAndAreaAndCitySelectedState();
    }
  }
}
