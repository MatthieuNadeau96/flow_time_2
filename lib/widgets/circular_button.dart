import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Icon? icon;
  final Function() onTap;
  final Function() onLongTap;

  const CircularButton({
    super.key,
    this.width,
    this.height,
    this.color,
    this.icon,
    required this.onTap,
    required this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongTap,
        borderRadius: BorderRadius.circular(100),
        splashColor: Theme.of(context).primaryColorLight,
        child: Ink(
          width: width ?? 117,
          height: height ?? 117,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
