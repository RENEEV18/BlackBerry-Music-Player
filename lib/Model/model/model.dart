class PlaylistSongModel {
   final String playlistname;

  PlaylistSongModel({required this.playlistname});

  static PlaylistSongModel fromMap(Map<String, Object?> map) {
    final playlistname = map['playlistname'] as String;

    return PlaylistSongModel(playlistname: playlistname);
  }

 
}
