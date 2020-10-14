import 'package:equatable/equatable.dart';
import 'package:flutter_MVVM/model/albums_list.dart';

abstract class AlbumsState extends Equatable{
  @override
  List<Object> get props => [];
}

class AlbumsLoading extends AlbumsState{}

class AlbumsLoaded extends AlbumsState{
  final List<Album> albums;
  AlbumsLoaded({this.albums});
}

class AlbumsListError extends AlbumsState{
  final error;
  AlbumsListError({this.error});
}

class AlbumsInitState extends AlbumsState{}