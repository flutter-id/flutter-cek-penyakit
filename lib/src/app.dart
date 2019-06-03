import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/blocs/kesehatanBloc.dart';
import 'package:cek_penyakit/src/resources/waveClipper.dart';
import 'package:cek_penyakit/src/resources/blocProvider.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  BuildContext mContext;
  List<Widget> widgetGejalaPenyakit = [];
  Map<int, dynamic> valueDropDown = Map();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final KesehatanBloc kesehatanBloc = BlocProvider.of(context).widget.bloc;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    kesehatanBloc.initGejalaPenyakit();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Cek Kesehatan",
              style: TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 0.3)]),
            ),
            Container(
              width: 45,
              height: 23,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFee4540),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Text(
                "BETA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
      body: Builder(
        builder: (secondContext) {
          mContext = secondContext;
          return Stack(
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
                  padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                  width: width,
                  height: height,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF455a64),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                spreadRadius: 0.1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "Gejala Penyakit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widgetGejalaPenyakit.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: <Widget>[
                                Card(
                                  elevation: 6,
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: DropdownButton(
                                        elevation: 6,
                                        isExpanded: true,
                                        hint:
                                            Text("Pilih Gejala Penyakit Anda"),
                                        value: valueDropDown[index] == null
                                            ? null
                                            : valueDropDown[index],
                                        onChanged: (onChange) {
                                          setState(() {
                                            valueDropDown[index] = onChange;
                                          });
                                        },
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        items: kesehatanBloc.listGejala,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.transparent,
                                  height: 4,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            onPressed: () async {
              if (await kesehatanBloc.checkKesehatan(valueDropDown)) {
                Navigator.of(context).pushNamed("/hasilkesehatan");
              } else {
                Scaffold.of(mContext).showSnackBar(SnackBar(
                    content: Text("Error, Mohon untuk segera lapor ke developer.")));
              }
            },
            label: Text("Cek"),
            icon: Icon(
              Icons.check,
            ),
            heroTag: "hasilCheck",
          ),
          Divider(
            color: Colors.transparent,
            height: 8,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                widgetGejalaPenyakit.add(SizedBox());
              });
            },
            label: Text("Tambah"),
            icon: Icon(
              Icons.add,
            ),
            heroTag: "tambahGejala",
          ),
        ],
      ),
    );
  }
}
