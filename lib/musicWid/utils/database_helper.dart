import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:glee/musicWid//models/my_track.dart';
import 'dart:io';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String trackTable = 'track_table';
  String colId = 'id';
  String colName = 'name';
  String colSId = 'sId';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'track_recommendations.db';

    // Open/create the database at a given path
    var trackDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return trackDatabase;
  }

  // Function that has sql query to create the table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $trackTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colName TEXT,'
        '$colSId TEXT)'
    );
  }

  Future<List<Map<String, dynamic>>> getTrackMapList() async {
    Database db = await this.database;
    var result = await db.query(trackTable, orderBy: '$colName ASC');
    return result;
  }

  Future<int> insertTrack(MyTrack myTrack) async {
    Database db = await this.database;
    var result = await db.insert(trackTable, myTrack.toMap());
    return result;
  }

  Future<int> deleteTrack(int id) async {
    Database db = await this.database;
    int result = await db.delete(trackTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $trackTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<MyTrack>> getTrackList() async {
    var trackMapList = await getTrackMapList();
    int count = trackMapList.length;

    List<MyTrack> trackList = List<MyTrack>();

    for (int i = 0; i < count; i++) {
      trackList.add(MyTrack.fromMapObject(trackMapList[i]));
    }

    return trackList;
  }

}
