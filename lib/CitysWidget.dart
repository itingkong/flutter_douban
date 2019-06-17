import 'package:flutter/material.dart';

class CitysWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CitysWidgetState();
  }
}

class CitysWidgetState extends State<CitysWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('城市选择'),
    );
  }
}
