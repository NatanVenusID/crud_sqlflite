 import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_app/model/model_mahasiswa.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  static Database _database;

  final String tableMahasiswa = 'mhsTable';
  final String columId = 'id';
  final String columnFirstName = 'firstname';
  final String columnLastName = 'lastname';
  final String columnMobileNo = 'mobileno';
  final String columnEmailId = 'emailid';
  final String columnFakultas = 'fakultas';
  final String columnProgdi = 'progdi';

  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mahasiswa.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableMahasiswa($columId INTEGER PRIMARY KEY, "
        "$columnFirstName TEXT, "
        "$columnLastName TEXT,"
        "$columnMobileNo TEXT, "
        "$columnEmailId TEXT,"
        "$columnFakultas TEXT,"
        "$columnProgdi TEXT)";
    await db.execute(sql);
  }

//Save Pegawai
  Future<int> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableMahasiswa, mahasiswa.toMap());
    return result;
  }

//Get All Pegawai
  Future<List> getAllMahasiswa() async {
    var dbClient = await db;
    var result = await dbClient.query(tableMahasiswa, columns: [
      columId,
      columnFirstName,
      columnLastName,
      columnMobileNo,
      columnEmailId,
      columnFakultas,
      columnProgdi
    ]);
    return result.toList();
  }

//Update Pegawai
  Future<int> updateMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await db;
    return await dbClient.update(tableMahasiswa, mahasiswa.toMap(),
        where: "$columId = ?", whereArgs: [mahasiswa.id]);
  }

//Delete Pegawai
  Future<int> deleteMahasiswa(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableMahasiswa, where: "$columId = ?", whereArgs: [id]);
  }
}
