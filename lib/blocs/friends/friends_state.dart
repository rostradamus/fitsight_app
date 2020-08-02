import 'package:equatable/equatable.dart';
import 'package:fitsight_app/models/user.dart';
import 'package:meta/meta.dart';

abstract class FriendsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendsLoadingState extends FriendsState {}

class FriendsLoadedState extends FriendsState {
  final List<User> friends;

  FriendsLoadedState({@required this.friends});
  @override
  List<Object> get props => [friends];
}
