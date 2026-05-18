import 'package:flutter/cupertino.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({
    super.key,
    required this.label,
    required this.colorValue,
    this.size = 44,
  });

  final String label;
  final int colorValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    final text = label.isEmpty ? '?' : label.substring(0, 1).toUpperCase();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(colorValue),
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.38,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
