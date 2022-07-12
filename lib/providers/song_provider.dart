import 'package:equatable/equatable.dart';
import '../models/song_model.dart';

class SongListState extends Equatable {
  final bool loading;
  final List<Song> songs;

  SongListState({this.loading, this.songs});

  @override
  List<Object> get props => [loading, songs];
}
