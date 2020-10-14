import 'package:flutter/material.dart';
import 'package:flutter_MVVM/bloc/albums/bloc.dart';
import 'package:flutter_MVVM/bloc/albums/events.dart';
import 'package:flutter_MVVM/bloc/albums/states.dart';
import 'package:flutter_MVVM/model/albums_list.dart';
import 'package:flutter_MVVM/widgets/error.dart';
import 'package:flutter_MVVM/widgets/list_row.dart';
import 'package:flutter_MVVM/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState(){ // spt useEffect di React
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async{
    context.bloc<AlbumsBloc>().add(AlbumEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
          builder: (
            BuildContext context, 
            AlbumsState state
          ){
          if (state is AlbumsListError){
            final error = state.error;
            String message = '${error.message}\nTap to Retry';  // \n => enter
            return ErrorTxt(
              message : message,
              onTap: _loadAlbums,
            );
          }
          if (state is AlbumsLoaded){
            List<Album> albums = state.albums;
            return _list(albums);
          }
          return Loading();
        }),
      ]
    );
  }

  // spt map di react
  Widget _list(List<Album> albums){
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index){
          Album album = albums[index];
          // return Text(album.title);
          return ListRow(album: album);
        },
      )
    );
  }
}