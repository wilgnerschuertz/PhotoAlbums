import 'package:mobx/mobx.dart';
import 'package:photo_albums/app/modules/home/models/user_model.dart';
import 'package:photo_albums/app/modules/home/models/album_model.dart';
import 'package:photo_albums/app/modules/home/services/user_service.dart';

part 'details_store.g.dart';

class DetailsStore = _DetailsStore with _$DetailsStore;

abstract class _DetailsStore with Store {
  final api = UserRequest();

  @observable
  UserModel? user;

  @observable
  AlbumModel? album;

  @action
  Future<void> fetchData(int albumId) async {
    final fetchedAlbum = await api.fetchAlbum(albumId);
    final fetchedUser = await api.fetchUser(fetchedAlbum!.userId!);

    user = fetchedUser;
    album = fetchedAlbum;
  }
}
