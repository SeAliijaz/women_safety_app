import 'package:flutter/material.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParentHomeScreen'),
      ),
      body: Center(
        child: Text('ParentHomeScreen'),
      ),
    );
  }
}
