import 'package:flutter/material.dart';

class EmptyAlternate extends StatelessWidget {
  final Widget? image;
  final String text;
  const EmptyAlternate({super.key, this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image ?? const SizedBox(),
        Center(child: Text(text),)
      ],
    );
  }
}