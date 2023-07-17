import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photo_albums/app/modules/home/services/photos_service.dart';
import 'package:photo_albums/app/modules/home/services/user_service.dart';

import 'models/photo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ConnectAPI();

  final apiDetail = UserRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Photo Albuns',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '?',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<PhotoModel>?>(
              future: api.fetchPhotos(),
              builder: (BuildContext context, AsyncSnapshot<List<PhotoModel>?> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Card(
                            child: InkWell(
                              onTap: () {
                                // apiDetail.fetchAlbum(snapshot.data![index].albumId!);
                                Modular.to.pushNamed('/details', arguments: snapshot.data![index]);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(snapshot.data![index].url!),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        child: Text(snapshot.data![index].title!),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        alignment: Alignment.topRight,
                                        child: Text('${snapshot.data![index].id!}'),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // Por padrão, mostra um loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      )),
    );
  }
}
