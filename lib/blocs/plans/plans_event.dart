import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PlansEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlansViewLoaded extends PlansEvent {}

class PlansListRefreshed extends PlansEvent {}

class DaySelected extends PlansEvent {
  final List selectedPlans;

  DaySelected({@required this.selectedPlans});
  @override
  List<Object> get props => [selectedPlans];
}
