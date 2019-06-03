import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseHelper {
  static final _databaseName = "cek_kesehatan.db";
  static final _databaseVersion = 1;
  List<Map<String, dynamic>> namaGejala = [
    {"nama": "Badan terasa lemas", "cf": 0.2},
    {"nama": "Cepat lelah", "cf": 0.2},
    {"nama": "Nyeri dada", "cf": 0.4},
    {"nama": "Pusing Berkunang kunang", "cf": 0.4},
    {"nama": "Sakit kepala", "cf": 0.4},
    {"nama": "Nyeri Tulang", "cf": 0.4},
    {"nama": "Kulit Pucat", "cf": 0.6},
    {"nama": "Penurunan Berat Badan", "cf": 0.4},
    {"nama": "Nyeri di Bagian Perut", "cf": 0.5},
    {"nama": "Kulit gatal dan terasa kering", "cf": 0.4},
    {"nama": "Sering merasa haus", "cf": 0.3},
    {"nama": "Sering buang air kecil", "cf": 0.5},
  ];

  List<Map<String, String>> namaPenyakit = [
    {"penyakit": "Anemia", "gejala": "1,2,3,4,5"},
    {"penyakit": "Leukimia", "gejala": "2,5,6,7,8"},
    {"penyakit": "Gula Darah Tinggi", "gejala": "2,5,8,9,10,11,12"},
  ];

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE gejala (id INTEGER PRIMARY KEY AUTOINCREMENT, nama_gejala TEXT, cf_pakar NUM)');
    await db.execute(
        'CREATE TABLE penyakit (id INTEGER PRIMARY KEY AUTOINCREMENT, nama_penyakit TEXT, gejala TEXT)');

    for (int x = 0; x < namaGejala.length; x++) {
      await db.rawQuery(
          "INSERT INTO gejala(nama_gejala, cf_pakar) VALUES('${namaGejala[x]['nama']}', ${namaGejala[x]['cf']}) ");
    }

    for (int x = 0; x < namaPenyakit.length; x++) {
      await db.rawQuery(
          'INSERT INTO penyakit(nama_penyakit, gejala) VALUES("${namaPenyakit[x]['penyakit']}", "${namaPenyakit[x]['gejala']}" ) ');
    }
  }
}
