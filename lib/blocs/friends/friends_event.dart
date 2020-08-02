import 'package:equatable/equatable.dart';

abstract class FriendsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendsViewLoaded extends FriendsEvent {}

class FriendsListRefreshed extends FriendsEvent {}
