import 'package:flutter/material.dart';
import 'package:flutter_MVVM/api/services.dart';
import 'package:flutter_MVVM/bloc/albums/bloc.dart';
import 'package:flutter_MVVM/screens/albums_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: BlocProvider(
        create: (context) => AlbumsBloc(albumsRepo: AlbumServices()),
        child: AlbumsScreen(),
      ),
    );
  }
}
