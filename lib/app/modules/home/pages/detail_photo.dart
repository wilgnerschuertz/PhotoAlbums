import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:photo_albums/app/modules/home/stores/detail_store.dart';

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
        title: Text(widget.photo.title!),
      ),
      body: Observer(
        builder: (_) {
          if (store.user == null || store.album == null) {
            return CircularProgressIndicator(); // Ajuste a posição do indicador de acordo com suas necessidades
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ID: ${widget.photo.id}'),
                  Text('User Name: ${store.user?.name}'),
                  Text('Album Title: ${store.album?.title}'),
                  Image.network(widget.photo.url!),
                  Text('Thumbnail:'),
                  Image.network(widget.photo.thumbnailUrl!),
                ],
              ),
            );
          }
        },
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Details Photo'),
    //     centerTitle: true,
    //   ),
    //   body: SafeArea(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Card(
    //           child: SizedBox(
    //             width: MediaQuery.of(context).size.width * 1,
    //             height: MediaQuery.of(context).size.height * 0.15,
    //             child: Row(
    //               children: [
    //                 SizedBox(
    //                   width: 100,
    //                   height: 100,
    //                   child: Image.network(widget.photo.thumbnailUrl!),
    //                 ),
    //                 const SizedBox(width: 10),
    //                 Container(
    //                   width: MediaQuery.of(context).size.width * 0.5,
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                   alignment: Alignment.center,
    //                   child: Text('${widget.photo.title}'),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
