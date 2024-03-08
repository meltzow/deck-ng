import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
// The loading indicator
        CircularProgressIndicator(),
        SizedBox(
          height: 15,
        ),
// Some text
        Text('Loading...')
      ],
    );
  }
}
