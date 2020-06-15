import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PlansState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlansLoadingState extends PlansState {}

class PlansLoadedState extends PlansState {
  // TODO: Temporary Model
  final Map<DateTime, List> plans;
  final List selectedPlans;

  PlansLoadedState({@required this.plans, @required this.selectedPlans});
  @override
  List<Object> get props => [plans];
}
