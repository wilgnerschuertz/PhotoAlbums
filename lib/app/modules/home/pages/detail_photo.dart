import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:photo_albums/app/modules/home/stores/details_store.dart';

import '../models/photo_model.dart';

class DetailsPage extends StatefulWidget {
  final PhotoModel photo;

  DetailsPage({required this.photo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsStore store = DetailsStore();

  @override
  void initState() {
    super.initState();
    store.fetchData(widget.photo.albumId!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Photo'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (store.user == null || store.album == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('@${store.user!.username}'.toLowerCase()),
                                ),
                                Image.network(
                                  widget.photo.url!,
                                  width: 600,
                                  // height: 300,
                                  // cacheHeight: 300,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              var lat = double.tryParse(store.user?.address?.geo?.lat ?? '0') ?? 0;
                                              var lng = double.tryParse(store.user?.address?.geo?.lng ?? '0') ?? 0;
                                              MapsLauncher.launchCoordinates(lat, lng);
                                            },
                                            icon: const Icon(Icons.pin_drop_rounded)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${store.user!.name}: ${store.album?.title}'),
                                    const SizedBox(height: 8),
                                    Text('Company: ${store.user?.company!.name}'),
                                    const SizedBox(height: 8),
                                    SizedBox(child: Text('Catch: ${store.user?.company!.catchPhrase}')),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
