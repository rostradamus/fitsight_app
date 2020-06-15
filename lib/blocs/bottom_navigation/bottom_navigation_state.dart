import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;
  CurrentIndexChanged({@required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class ViewLoading extends BottomNavigationState {}

class HomeViewState extends BottomNavigationState {}

class FriendsViewState extends BottomNavigationState {}

class PlanViewState extends BottomNavigationState {}

class TipsViewState extends BottomNavigationState {}

class SettingsViewState extends BottomNavigationState {}
