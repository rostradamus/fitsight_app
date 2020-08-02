import 'package:fitsight_app/blocs/plans/plans_event.dart';
import 'package:fitsight_app/blocs/plans/plans_state.dart';
import 'package:fitsight_app/services/plans_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansService _plansService = GetIt.I.get<PlansService>();
  Map<DateTime, List> _plans = {};
  @override
  PlansState get initialState => PlansLoadingState();

  @override
  Stream<PlansState> mapEventToState(PlansEvent event) async* {
    if (event is PlansViewLoaded) {
      this.add(PlansListRefreshed());
    }
    if (event is PlansListRefreshed) {
      yield PlansLoadingState();
      _plans = await _plansService.fetchPlans();
      yield PlansLoadedState(
        plans: _plans,
        selectedPlans: _plans[_plansService.selectedDay] ?? [],
      );
    }
    if (event is DaySelected) {
      yield PlansLoadingState();
      yield PlansLoadedState(plans: _plans, selectedPlans: event.selectedPlans);
    }
  }
}
