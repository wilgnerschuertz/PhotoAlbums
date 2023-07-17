// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsStore on _DetailsStore, Store {
  late final _$userAtom = Atom(name: '_DetailsStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$albumAtom = Atom(name: '_DetailsStore.album', context: context);

  @override
  AlbumModel? get album {
    _$albumAtom.reportRead();
    return super.album;
  }

  @override
  set album(AlbumModel? value) {
    _$albumAtom.reportWrite(value, super.album, () {
      super.album = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_DetailsStore.fetchData', context: context);

  @override
  Future<void> fetchData(int albumId) {
    return _$fetchDataAsyncAction.run(() => super.fetchData(albumId));
  }

  @override
  String toString() {
    return '''
user: ${user},
album: ${album}
    ''';
  }
}
