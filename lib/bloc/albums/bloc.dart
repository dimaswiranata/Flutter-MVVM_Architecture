import 'dart:io';

import 'package:flutter_MVVM/api/exceptions.dart';
import 'package:flutter_MVVM/api/services.dart';
import 'package:flutter_MVVM/bloc/albums/events.dart';
import 'package:flutter_MVVM/bloc/albums/states.dart';
import 'package:flutter_MVVM/model/albums_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsBloc extends Bloc<AlbumEvents, AlbumsState>{

  final AlbumsRepo albumsRepo;
  List<Album> albums;

  AlbumsBloc({this.albumsRepo}) : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumEvents event) async* {
    switch (event){
      case AlbumEvents.fetchAlbums:
        yield AlbumsLoading();
        try{
          albums = await albumsRepo.getAlbumList();
          yield AlbumsLoaded(albums: albums);
        } on SocketException {
          yield AlbumsListError(
            error: NoInternetException('No Internet')
          );
        } on HttpException {
          yield AlbumsListError(
            error: NoServiceFoundException('No Service Found')
          );
        } on FormatException {
          yield AlbumsListError(
            error: InvalidFormatException('Invalid Response Format')
          );
        } catch (e) {
          yield AlbumsListError(
            error: UnknownException('Unknown Error')
          );
        }
        break;
    }
  }

}