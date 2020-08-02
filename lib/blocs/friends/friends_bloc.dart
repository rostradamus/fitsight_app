import 'package:fitsight_app/blocs/friends/friends_event.dart';
import 'package:fitsight_app/blocs/friends/friends_state.dart';
import 'package:fitsight_app/models/user.dart';
import 'package:fitsight_app/services/friends_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsService _friendsService = GetIt.I.get<FriendsService>();
  @override
  FriendsState get initialState => FriendsLoadingState();

  @override
  Stream<FriendsState> mapEventToState(FriendsEvent event) async* {
    if (event is FriendsViewLoaded) {
      this.add(FriendsListRefreshed());
    }
    if (event is FriendsListRefreshed) {
      yield FriendsLoadingState();
      List<User> friends = await _friendsService.fetchUsers();
      yield FriendsLoadedState(friends: friends);
    }
  }
}
