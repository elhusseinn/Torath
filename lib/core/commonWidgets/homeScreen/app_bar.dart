import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: shadows(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: shadows(),
            // home icon
          ),
          Container(
            // application name
            decoration: shadows(),
          )
        ],
      ),
    );
  }

  ShapeDecoration shadows() {
    return ShapeDecoration(
      shadows: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
      color: const Color(0xFF4A6848),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
