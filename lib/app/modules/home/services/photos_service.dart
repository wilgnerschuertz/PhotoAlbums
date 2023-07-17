import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_albums/app/modules/home/models/photo_model.dart';
import 'package:photo_albums/app/modules/home/services/user_service.dart';

class ConnectAPI {
  final photoURL = 'https://jsonplaceholder.typicode.com/photos';
  final apiUser = UserRequest();

  Future<List<PhotoModel>?> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse(photoURL));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final photos = jsonList.map((json) => PhotoModel.fromJson(json)).toList();
        return photos;
      }
    } catch (errPhotos) {
      throw Exception('O Problema é.. $errPhotos');
    }
    return null;
  }
}



/**
 * import 'dart:convert';
  Future<VeiculosModel?> fetchVeiculos() async {
    try {
      if (await verificaInternet.checkInternetConnection()) {
        final response = await http.get(Uri.parse('$url/veiculo'), headers: {'Authorization': 'Bearer ${box.read('token')}'});

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final veiculos = VeiculosModel.fromJson(json);
          await box.write('veiculos', json);
          return veiculos;
        } else if (response.statusCode == 500) {
          throw Exception('Erro interno no servidor');
        } else if (response.statusCode == 401) {
          throw Exception('Token inválido ou expirado!');
        } else if (response.statusCode.isNaN) {
          throw Exception('?!?!?!?');
        } else {
          throw Exception('? Falha ao carregar os dados');
        }
      } else {
        final json = box.read('veiculos');
        if (json != null) {
          return VeiculosModel.fromJson(json);
        }

        if (kDebugMode) {
          print('Carregando informações do localStorage');
        }
      }
    } on SocketException catch (err) {
      throw Exception('Falha ao carregar os dados $err ??');
    }
    return null;
  }
}

 */