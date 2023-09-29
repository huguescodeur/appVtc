import 'package:flutter/material.dart';

class WidgetSocialButton extends StatelessWidget {
  final Function()? onTap;
  final String image;
  const WidgetSocialButton({Key? key, required this.onTap, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: Colors.white38,
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
