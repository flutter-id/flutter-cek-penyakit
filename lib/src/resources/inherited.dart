import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/resources/blocProvider.dart';

class Inherit extends InheritedWidget{

  final BlockProviderState data;

  Inherit({Key key, @required this.data, @required Widget child}) : super(key : key, child : child);

  static BlockProviderState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Inherit) as Inherit).data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}