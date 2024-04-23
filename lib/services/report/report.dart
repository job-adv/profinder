import 'dart:convert';
import 'package:profinder/models/report/report.dart';
import 'package:profinder/services/data.dart';

class ReportService {
  final GenericDataService<ReportEntity> _genericService =
      GenericDataService<ReportEntity>('report', {
    'post': 'create',
  });

  Future<Map<String, bool>> post(ReportEntity entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
