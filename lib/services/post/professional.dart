import 'dart:convert';
import 'package:profinder/models/post/service.dart';
import 'package:profinder/models/post/service_creation_request.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/models/post/service_detail.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/utils/constants.dart';

class ProfessionalService {
  final url = Constants.apiUrl;

  final GenericDataService<ServiceEntity> _genericService =
      GenericDataService<ServiceEntity>('service', {
    'get': 'viewall',
    'post': 'create',
  });

  Future<List<ServiceEntity>> fetch() async {
    return _genericService.fetch((json) => ServiceEntity.fromJson(json));
  }

  Future<Map<String, bool>> post(ServiceCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<ServiceDetailEntity> fetchService(
      ServiceDetailEntity Function(
        Map<String, dynamic> json,
      ) fromJson,
      int? id) async {
    final response =
        await http.get(Uri.parse('$url/service/getoneservice/$id'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final jsonData = parsed['data'];

      final serviceEntity = fromJson(jsonData);
      return serviceEntity;
    } else {
      throw Exception('Failed to load service');
    }
  }
}
