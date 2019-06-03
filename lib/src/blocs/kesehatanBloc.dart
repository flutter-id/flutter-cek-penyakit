import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/model/modelKesehatan.dart';
import 'package:cek_penyakit/src/database/database.dart';
import 'package:cek_penyakit/src/resources/blocProvider.dart';

class KesehatanBloc extends BlocBase {
  List<DropdownMenuItem> listGejala = [];
  Map resultCekKesehatan = Map();
  List<ModelKesehatan> hasilKesehatan = [];

  initGejalaPenyakit() async {
    Database db = await DatabaseHelper.instance.database;
    var sql = await db.rawQuery("SELECT * FROM gejala");
    if (listGejala.length > 0) {
      listGejala.clear();
    }
    if (sql != null && sql.length > 0) {
      for (int i = 0; i < sql.length; i++) {
        DropdownMenuItem ddmi = DropdownMenuItem(
          child: Text(sql[i]['nama_gejala']),
          value: (i + 1).toString(),
        );
        listGejala.add(ddmi);
      }
    }
  }

  checkKesehatan(Map<int, dynamic> listGejala) async {
    Database db = await DatabaseHelper.instance.database;
    List tempGejala = listGejala.values.toList();
    String gejalaAsString = "";
    resultCekKesehatan.clear();
    hasilKesehatan.clear();
    tempGejala
        .sort((dataA, dataB) => int.parse(dataA).compareTo(int.parse(dataB)));
    tempGejala.forEach((idGejala) {
      if (gejalaAsString.length == 0) {
        gejalaAsString = idGejala.toString();
      } else {
        gejalaAsString = gejalaAsString + "," + idGejala.toString();
      }
    });
    var sqlPenyakit = await db.rawQuery("SELECT * FROM penyakit");

    for (int i = 0; i < sqlPenyakit.length; i++) {
      String temp = (sqlPenyakit[i]['gejala']);
      var resultSplit = temp.split(",");
      for (int x = 0; x < tempGejala.length; x++) {
        for (int y = 0; y < resultSplit.length; y++) {
          if (tempGejala[x] == resultSplit[y]) {
            if (resultCekKesehatan[sqlPenyakit[i]['nama_penyakit']] == null) {
              resultCekKesehatan[sqlPenyakit[i]['nama_penyakit']] = "";
            }
            if (y == 0) {
              resultCekKesehatan[sqlPenyakit[i]['nama_penyakit']] +=
                  tempGejala[x];
            } else {
              resultCekKesehatan[sqlPenyakit[i]['nama_penyakit']] +=
                  "," + tempGejala[x];
            }
            break;
          }
        }
      }
    }

    int indexAsNumber = 0;
    for (var item in resultCekKesehatan.values) {
      List keys = resultCekKesehatan.keys.toList();
      var data = item.toString().split(",");
      if (data.length > 1) {
        var cf1;
        var resultSementara;
        var oldCf;
        for (int i = 0; i < data.length; i++) {
          var cf2;
          var sql1 =
              await db.rawQuery("SELECT * FROM gejala where id = '${data[i]}'");
          if (sql1.length > 0) {
            for (int z = 0; z < sql1.length; z++) {
              if (z == 0) {
                cf1 = sql1[0]['cf_pakar'];
                resultCekKesehatan[keys[indexAsNumber]] = cf1;
              } else if (z == 1) {
                cf2 = sql1[0]['cf_pakar'];
                resultSementara = cf1 + cf2 * (1 - cf1);
                oldCf = resultSementara;
                resultCekKesehatan[keys[indexAsNumber]] = resultSementara;
              } else if (z >= 2) {
                cf2 = sql1[0]['cf_pakar'];
                resultSementara = oldCf + cf2 * (1 - oldCf);
                oldCf = resultSementara;
                resultCekKesehatan[keys[indexAsNumber]] = resultSementara;
              }
            }
          }
        }
      } else {
        var sql =
            await db.rawQuery("SELECT * FROM gejala WHERE id = '${data[0]}' ");
        if (sql.length > 0) {
          resultCekKesehatan[keys[indexAsNumber]] = sql[0]['cf_pakar'];
        }else{
          return false;
        }
      }
      indexAsNumber++;
    }

    for (int x = 0; x < resultCekKesehatan.length; x++) {
      List tempKeys = resultCekKesehatan.keys.toList();
      ModelKesehatan model = ModelKesehatan(
        nama: tempKeys[x],
        hasil: num.parse((resultCekKesehatan[tempKeys[x]] * 100).toString()),
      );
      hasilKesehatan.add(model);
    }
    return true;
  }

  @override
  void dispose() {}
}
