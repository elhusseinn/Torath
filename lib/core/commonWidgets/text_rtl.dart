import 'package:flutter/material.dart';
class RtlText extends StatelessWidget {
  String content;
  TextStyle? style;

  RtlText({required this.content, this.style, super.key});


  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: style,
      textDirection: TextDirection.rtl,
    );
  }
}
