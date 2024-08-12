import 'package:flutter/material.dart';
import 'package:manga_reader/base/ui/widgets/custom_text.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const ProgressBar({
    super.key,
    required this.value,
    this.height = 8.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final double porcent = value * 100;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                width: constraints.maxWidth * value,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              Positioned(
                top: constraints.maxWidth * 0.018,
                left: constraints.maxWidth * 0.45,
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: "${porcent.toInt()}%",
                  fontSize: constraints.maxWidth * 0.08,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
