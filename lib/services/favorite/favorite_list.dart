import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/services/data.dart';

class FavoriteListService {
  final GenericDataService<Favorite> _genericService =
      GenericDataService<Favorite>('favorite', {
    'get': 'view',
  });

  Future<List<Favorite>> fetch() async {
    return _genericService.fetch((json) => Favorite.fromJson(json));
  }
}
