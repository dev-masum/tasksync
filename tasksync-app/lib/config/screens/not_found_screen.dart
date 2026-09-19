import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String? path;
  final String? name;
  const NotFoundScreen({super.key, this.path, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('404 | Screen not found'),
            Text('Path: $path'),
            Text('Name: $name'),
          ],
        ),
      ),
    );
  }
}
