import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool loading;
  final double? width;

  MainButton(
      {required this.onPressed,
      required this.text,
      this.loading = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loading ? null : onPressed as Function(),
      height: 60,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: width ?? 250,
      color: Colors.brown,
      hoverColor: Colors.transparent,
      focusColor: Colors.black12,
      disabledColor: Colors.brown,
      highlightColor: Colors.black12,
      splashColor: Colors.black12,
      child: loading
          ? SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(text),
    );
  }
}
