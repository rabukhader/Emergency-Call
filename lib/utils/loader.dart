import 'package:emergancy_call/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderWidget extends StatelessWidget {
  final double? size;
  const LoaderWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.bouncingBall(color: kPrimaryColor, size: size ?? 24),
    );
  }
}