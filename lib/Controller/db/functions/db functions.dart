



import 'dart:developer';

import 'package:demo/Model/model/model.dart';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDb extends ChangeNotifier {
   List<SongModel> favsongModel = [];
   List<PlaylistSongModel>playlistModel=[];
   List<SongModel> songsPlaylist = [];
  
 

  static late Database db;
  static late Database dbPlay;
  static late Database dbplayadd;

  static Future<void> initializeDatabase() async {
    db = await openDatabase(
      'music.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS music (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, _uri TEXT, _data TEXT, title TEXT, artist TEXT, _display_name_wo_ext TEXT)');
      },
     
    );

    dbPlay = await openDatabase(
      'playlist.db',
      version: 1,
      onCreate: (Database dbPlay, int version) async {
        await dbPlay.execute(
            'CREATE TABLE IF NOT EXISTS playlist (id INTEGER PRIMARY KEY, playlistname TEXT)');
      },
    );

    dbplayadd = await openDatabase(
      'playlistadd.db',
      version: 1,
      onCreate: (Database dbplayadd, int version) async {
        await dbplayadd.execute(
            'CREATE TABLE IF NOT EXISTS addsongs (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, _uri TEXT, _data TEXT, title TEXT, artist TEXT, _display_name_wo_ext TEXT, playlistname TEXT)');
      },
    );

     
  }


   Future<void> addFav(SongModel song) async {
    int id = await db.rawInsert(
        'INSERT INTO music (_id,_uri,_data,title,artist,_display_name_wo_ext) VALUES (?,?,?,?,?,?)',
        [
          song.id,
          song.uri,
          song.data,
          song.title,
          song.artist,
          song.displayNameWOExt
        ]);
   favsongModel.add(song);
   // musicListNotifier.value.add(song);
    print(id);
    getAllMusic();
    notifyListeners();
    // FavoriteDb.musicListNotifier.notifyListeners();
     
  }



  // add fav function///////////////////////////////////////






   Future<void> getAllMusic() async {
    final music = (await db.rawQuery('SELECT * FROM music'));

    print(music);
     favsongModel.clear();
    // musicListNotifier.value.clear();
    for (var map in music) {
      final song = SongModel(map);
    
      favsongModel.add(song);
      notifyListeners();
      //musicListNotifier.value.add(song);
    }
  }


  //getAll music function ///////////////////////////////////







   Future<bool>isFav(dynamic id)async{
   
    final music = (await db.rawQuery('SELECT * FROM music WHERE _id = ?',[id]));
     notifyListeners();
    return music.isNotEmpty;

  }


  //isfav checking///////////////////////////////////////////////




   Future<void> removeFav(int id) async {
    await db.delete('music', where: '_id = ?', whereArgs: [id]);
       
        getAllMusic();
         notifyListeners();
    // musicListNotifier.notifyListeners();

  }


  // remove fav//////////////////////////////////////////////////////



   Future<void> addPlaylist(PlaylistSongModel songModel) async {
    dbPlay.rawQuery('INSERT INTO playlist (playlistname) VALUES (?)',
        [songModel.playlistname]);
    getPlaylist();
    playlistModel.add(songModel);
    notifyListeners();
    // playListNotifier.value.add(songModel);
    // FavoriteDb.playListNotifier.notifyListeners();
  }


//getting playlist /////////////////////////////////////////////




   Future<void> getPlaylist() async {
    final playlist = await dbPlay.rawQuery('SELECT * FROM playlist');
    print(playlist);
    playlistModel.clear();
    // playListNotifier.value.clear();

    for (var map in playlist) {
      final songPlaylist = PlaylistSongModel.fromMap(map);
    
      playlistModel.add(songPlaylist);
      //playListNotifier.value.add(songPlaylist);
    }
     // playListNotifier.notifyListeners();
     notifyListeners();
  }



////////////////////////////////////////////////////////////////////


//remove playlist
   Future<void> removePlayLst(String playlistname) async {
    await dbPlay.delete('playlist',
        where: 'playlistname = ?', whereArgs: [playlistname]);
    getPlaylist();
    dbplayadd.delete('addsongs');
    notifyListeners();
    //playListNotifier.notifyListeners();
  }

/////////////////////////////////////////////////////////////////////


   Future<void> addplaylistSongs(SongModel song, String playlistname) async {
    int id = await dbplayadd.rawInsert(
        'INSERT INTO addsongs (_id,_uri,_data,title,artist,_display_name_wo_ext,playlistname) VALUES (?,?,?,?,?,?,?)',
        [
          song.id,
          song.uri,
          song.data,
          song.title,
          song.artist,
          song.displayNameWOExt,
          playlistname
        ]);
    songsPlaylist.add(song);
   // songsNotifier.value.add(song);


    log(id.toString());
    getAllPlayListSongs(playlistname);
    notifyListeners();
    //FavoriteDb.songsNotifier.notifyListeners();
  }

   Future<void> getAllPlayListSongs(String playlistname) async {
    final music = (await dbplayadd.rawQuery('SELECT * FROM addsongs WHERE playlistname = ? ',[playlistname]));
    print(music);
    songsPlaylist.clear();
   // songsNotifier.value.clear();
    for (var map in music) {
      final song = SongModel(map);
     songsPlaylist.add(song);
     notifyListeners();
      //songsNotifier.value.add(song);
    }
  }
    Future<void> removePlaylstSong(int id, String playlistname) async {
    await dbplayadd.delete('addsongs', where: '_id = ?', whereArgs: [id]);
    getAllPlayListSongs(playlistname);
    notifyListeners();
    //songsNotifier.notifyListeners();
  }
 

  static Future<void> closeDB() async {
    await db.close();
    await dbPlay.close();
    await dbplayadd.close();
  }
   Future<void>reset()async{

    await db.delete('music');
    await dbPlay.delete('playlist');
    await dbplayadd.delete('addsongs');
    notifyListeners();
  }
  

}
