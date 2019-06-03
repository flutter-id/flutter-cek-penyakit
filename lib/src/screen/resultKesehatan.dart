import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/resources/waveClipper.dart';
import 'package:cek_penyakit/src/blocs/kesehatanBloc.dart';
import 'package:cek_penyakit/src/resources/blocProvider.dart';

class ResultKesehatan extends StatefulWidget {
  @override
  _ResultKesehatanState createState() => _ResultKesehatanState();
}

class _ResultKesehatanState extends State<ResultKesehatan> {
  List namaPenyakit = List();
  List hasilKesehatan = List();
  bool isShowing = false;

  initApp() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isShowing = true;
    });
  }

  @override
  void initState() {
    initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final KesehatanBloc kesehatanBloc = BlocProvider.of(context).widget.bloc;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    namaPenyakit = kesehatanBloc.resultCekKesehatan.keys.toList();
    hasilKesehatan = kesehatanBloc.resultCekKesehatan.values.toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Hasil",
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: ClipPath(
              child: Container(
                padding: const EdgeInsets.all(5),
                width: width,
                height: height / 3,
                color: Theme.of(context).primaryColor,
              ),
              clipper: Wave(),
            ),
          ),
          Positioned.fill(
            child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  Divider(
                    color: Colors.transparent,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFF684949),
                    ),
                    child: Text(
                      "Hasil Cek Kesehatan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  Expanded(
                    child: isShowing
                        ? ListView.builder(
                            itemCount: kesehatanBloc.hasilKesehatan.length,
                            itemBuilder: (ctx, index) {
                              if (index ==
                                  kesehatanBloc.hasilKesehatan.length - 1) {
                                return Column(
                                  children: <Widget>[
                                    Card(
                                      elevation: 6,
                                      child: ListTile(
                                        title: Text(
                                          kesehatanBloc
                                              .hasilKesehatan[index].nama,
                                        ),
                                        subtitle: Text(
                                          "Kemungkinan : " +
                                              kesehatanBloc
                                                  .hasilKesehatan[index].hasil
                                                  .toString() +
                                              " %",
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 6,
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 10, 2, 10),
                                        child: ListTile(
                                          title: Text(
                                            "Catatan Penting",
                                          ),
                                          subtitle: Text(
                                            "Dimohon untuk langsung percaya, karena aplikasi ini hanya simulasi. Dan data untuk pengecekan didapatkan dengan analisa pihak kami bukan dari pakar. Dan disarankan untuk pemeriksaan lebih lanjut.",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                  ],
                                );
                              } else {
                                return Card(
                                  elevation: 6,
                                  child: ListTile(
                                    title: Text(
                                      kesehatanBloc.hasilKesehatan[index].nama,
                                    ),
                                    subtitle: Text(
                                      "Kemungkinan : " +
                                          kesehatanBloc
                                              .hasilKesehatan[index].hasil
                                              .toString() +
                                          " %",
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
