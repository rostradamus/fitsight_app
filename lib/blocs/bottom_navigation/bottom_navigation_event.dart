import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MainPageLoaded extends BottomNavigationEvent {}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index});

  @override
  List<Object> get props => [index];
}
