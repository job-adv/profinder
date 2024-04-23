import 'package:profinder/models/usage_condition/usage_condition.dart';
import 'package:profinder/services/data.dart';

class UsagConditionsService {
  final GenericDataService<UsageCondition> _genericService =
      GenericDataService<UsageCondition>('userCondition', {
    'get': 'view',
  });

  Future<List<UsageCondition>> fetch() async {
    return _genericService.fetch((json) => UsageCondition.fromJson(json));
  }
}
