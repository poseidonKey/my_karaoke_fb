import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_karaoke_fb/constants/db_contants.dart';
import '../models/song_model.dart';

class SongListState extends Equatable {
  final bool loading;
  final List<Song> songs;

  SongListState({this.loading, this.songs});
  SongListState copyWith({bool loading, List<Song> songs}) {
    return SongListState(
      loading: loading ?? this.loading,
      songs: songs ?? this.songs,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, songs];
}

class SongList extends ChangeNotifier {
  SongListState state = SongListState(loading: false, songs: []);
  void handleError(Exception e) {
    print(e);
    state = state.copyWith(loading: false);
    notifyListeners();
  }

  Future<void> getAllNotes(String userId) async {
    state = state.copyWith(loading: true);
    notifyListeners();
    try {
      QuerySnapshot userSongsSnapshot = await songsRef
          .doc(userId)
          .collection("userSongs")
          .orderBy("timestamp", descending: true)
          .get();
      List<Song> songs = userSongsSnapshot.docs.map((songDoc) {
        return Song.fromDoc(songDoc);
      }).toList();
      state.copyWith(loading: false, songs: songs);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> addSong(Song newSong) async {
    state = state.copyWith(loading: true);
    notifyListeners();
    try {
      DocumentReference docRef =
          await songsRef.doc(newSong.songOwnerId).collection("userSongs").add({
        "songOwnerId": newSong.songOwnerId,
        "songID": newSong.id,
        "songName": newSong.songName,
        "songGYNumber": newSong.songGYNumber,
        "songTJNumber": newSong.songTJNumber,
        "songJanre": newSong.songJanre,
        "songUtubeAddress": newSong.songUtubeAddress,
        "songETC": newSong.songETC,
        "timestamp": newSong.timestamp
      });
      final song = Song(
          id: docRef.id,
          songOwnerId: newSong.songOwnerId,
          songID: newSong.id,
          songName: newSong.songName,
          songGYNumber: newSong.songGYNumber,
          songTJNumber: newSong.songTJNumber,
          songJanre: newSong.songJanre,
          songUtubeAddress: newSong.songUtubeAddress,
          songETC: newSong.songETC,
          timestamp: newSong.timestamp);
      state = state.copyWith(loading: false, songs: [song, ...state.songs]);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> updateSong(Song song) async {
    state = state.copyWith(loading: true);
    notifyListeners();
    try {
      await songsRef
          .doc(song.songOwnerId)
          .collection("userSonges")
          .doc(song.id)
          .update({
        "songName": song.songName,
        "songGYNumber": song.songGYNumber,
        "songTJNumber": song.songTJNumber,
        "songJanre": song.songJanre,
        "songUtubeAddress": song.songUtubeAddress,
        "songETC": song.songETC,
      });
      final songs = state.songs.map((e) {
        return e.id == song.id
            ? Song(
                id: e.id,
                songID: song.id,
                songName: song.songName,
                songGYNumber: song.songGYNumber,
                songTJNumber: song.songTJNumber,
                songJanre: song.songJanre,
                songUtubeAddress: song.songUtubeAddress,
                songETC: song.songETC,
              )
            : e;
      }).toList();
      state = state.copyWith(loading: false, songs: songs);
      notifyListeners();
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> removeSong(Song song) async {
    state = state.copyWith(loading: true);
    notifyListeners();
    try {
      await songsRef
          .doc(song.songOwnerId)
          .collection("userSongs")
          .doc(song.id)
          .delete();
      final songs =
          state.songs.where((element) => element.id != song.id).toList();
      state = state.copyWith(loading: false, songs: songs);
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
