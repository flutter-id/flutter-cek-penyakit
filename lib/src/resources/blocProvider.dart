import 'package:flutter/material.dart';
import 'package:cek_penyakit/src/resources/inherited.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  BlockProviderState<T> createState() => BlockProviderState<T>();

  static BlockProviderState of<T extends BlocBase>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Inherit) as Inherit).data;
  }
}

class BlockProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Inherit(
      data: this,
      child: widget.child,
    );
  }
}
