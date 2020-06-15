import 'package:fitsight_app/blocs/bottom_navigation/bottom_navigation_event.dart';
import 'package:fitsight_app/blocs/bottom_navigation/bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int currentIndex = 0;

  @override
  BottomNavigationState get initialState => ViewLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is MainPageLoaded) {
      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: event.index);
      yield ViewLoading();

      switch (this.currentIndex) {
        case 0:
          {
            yield HomeViewState();
            break;
          }
        case 1:
          {
            yield FriendsViewState();
            break;
          }
        case 2:
          {
            yield PlanViewState();
            break;
          }
        case 3:
          {
            yield TipsViewState();
            break;
          }
        case 4:
          {
            yield SettingsViewState();
            break;
          }
        default:
          {}
      }
    }
  }
}
