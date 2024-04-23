import 'package:profinder/models/post/user_service.dart';
import 'package:profinder/services/data.dart';

class UserPostService {
  final GenericDataService<ServiceDataEntity> _genericUserService =
      GenericDataService<ServiceDataEntity>('service', {
    'get': 'viewmyservices',
    'post': 'create',
  });

  Future<List<ServiceDataEntity>> fetchUserServices() async {
    return _genericUserService
        .fetch((json) => ServiceDataEntity.fromJson(json));
  }
}
