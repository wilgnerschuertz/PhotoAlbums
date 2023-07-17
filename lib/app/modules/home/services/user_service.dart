// https://jsonplaceholder.typicode.com/users/1

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:photo_albums/app/modules/home/models/album_model.dart';
import 'package:photo_albums/app/modules/home/models/user_model.dart';

class UserRequest {
  final userURL = 'https://jsonplaceholder.typicode.com/users/';
  final albumURL = 'https://jsonplaceholder.typicode.com/albums/';

  Future<UserModel?> fetchUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$userURL/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = UserModel.fromJson(json);
        log('User = ${user.name}');
        return user;
      }
    } catch (errUser) {
      throw Exception('O Problema é.. $errUser');
    }
    return null;
  }

  Future<AlbumModel?> fetchAlbum(int id) async {
    try {
      final response = await http.get(Uri.parse('$albumURL/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final album = AlbumModel.fromJson(json);
        log('${album.userId}');
        fetchUser(album.userId!);
        return album;
      }
    } catch (errAlbum) {
      throw Exception('O Problema é.. $errAlbum');
    }
    return null;
  }
}
