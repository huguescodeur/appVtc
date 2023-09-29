import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool isLoadingProcess;

  const WidgetButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isLoadingProcess});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              foregroundColor: Colors.white,
              backgroundColor:
                  const Color(0xFF256B3F) /*Colors.black87.withOpacity(0.7)*/,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: Center(
              child: isLoadingProcess
                  ? CircularProgressIndicator(
                      color: Colors.yellow.withOpacity(0.9),
                    )
                  : Text(
                      text,
                      style: const TextStyle(fontSize: 18),
                    ))),
    );
  }
}
