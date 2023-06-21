import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded expands its child
        // to fill the available space.
        Expanded(
          child: title,
        ),
      ],
    );
  }
}
