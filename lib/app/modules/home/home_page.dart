import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_albums/app/modules/home/services/photos_service.dart';
import 'package:photo_albums/app/modules/home/services/user_service.dart';
import 'package:photo_albums/app/modules/home/stores/search_store.dart';

import 'models/photo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ConnectAPI();
  final apiDetail = UserRequest();
  final searchStore = SearchStore();

  List<PhotoModel>? photos;

  @override
  void initState() {
    super.initState();

    reaction((_) => searchStore.searchText, (String searchText) {
      fetchPhotos();
    });

    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    photos = await api.fetchPhotos();
    setState(() {}); // Calling setState to trigger a rebuild when photos are loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Albums'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {
                  searchStore.setSearchText(value);
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 1,
              child: Observer(
                builder: (_) {
                  if (photos == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    var filteredData = photos!.where((photo) => photo.title!.contains(searchStore.searchText)).toList();
                    return ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Card(
                              child: InkWell(
                                onTap: () {
                                  Modular.to.pushNamed('/details', arguments: filteredData[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(filteredData[index].url!),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        child: Text(filteredData[index].title!),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        alignment: Alignment.topRight,
                                        child: Text('${filteredData[index].id!}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
