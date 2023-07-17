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
                                Stack(
                                  children: [
                                    Image.network(
                                      widget.photo.url!,
                                      width: 450,
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 5,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            var lat = double.tryParse(store.user?.address?.geo?.lat ?? '0') ?? 0;
                                            var lng = double.tryParse(store.user?.address?.geo?.lng ?? '0') ?? 0;
                                            MapsLauncher.launchCoordinates(lat, lng);
                                          },
                                          icon: const Icon(
                                            Icons.pin_drop_rounded,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${store.user!.name}: '.toLowerCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${widget.photo.title}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'album title: '.toLowerCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${store.album!.title!}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
