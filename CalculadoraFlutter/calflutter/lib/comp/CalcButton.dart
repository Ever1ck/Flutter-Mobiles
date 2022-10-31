import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function? callback;
  const CalcButton({
    Key? key,
    this.text,
    this.fillColor = 0xFFFFB74D,
    this.textColor = 0xFF6C807F,
    this.textSize = 20,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//Size media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
// Foreground color
            onPrimary: Theme.of(context).colorScheme.onPrimary,
// Background color
            primary: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
/*shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(50.0),
),*/
          onPressed: () {
            callback!(text);
          },
          child: Text(
            text!,
          ),
//color: Color(fillColor),
//textColor: Color(textColor),
        ),
      ),
    );
  }
}
