import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class BaseRepository {
  BaseRepository();
  BaseRepository._();
  static final BaseRepository db = BaseRepository._();
  Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path + "dataapp.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE persona(' +
          'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
          'dni TEXT,' +
          'nombre TEXT,' +
          'apellido_paterno TEXT,' +
          'apellido_materno TEXT,' +
          'telefono INTEGER,' +
          'genero TEXT,' +
          'correo TEXT )');
    });
  }
}
