import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_service.dart';
import 'exceptions/common_http_exception.dart';

class PlansService {
  ApiService get _apiService => GetIt.I.get<ApiService>();
  final DateTime selectedDay = DateTime.now();

  Future<Map<DateTime, List>> fetchPlans() async {
    try {
      // TODO: Replace with actual REST call
      await Future.delayed(const Duration(milliseconds: 500));
      return this.getMockPlans();
    } on DioError catch (e) {
      if (e.response != null) throw FetchFailedException();
      throw UnexpectedPlansException();
    }
  }

  Map<DateTime, List> getMockPlans() {
    return {
      selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
  }
}

class UnexpectedPlansException extends DioError {}
