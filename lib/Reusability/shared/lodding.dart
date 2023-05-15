import 'package:flutter/material.dart';

class LoadingAni extends StatelessWidget {
  final bool isTransparent;
  const LoadingAni({Key? key, this.isTransparent = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    isTransparent? new Container(
    color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container()
    ]);
  }
}