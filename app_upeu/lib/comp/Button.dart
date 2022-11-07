import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onTap;
  final String label;

  const Button({Key key, this.onTap, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2),
          child: SizedBox(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).colorScheme.onSecondary,
                primary: Theme.of(context).colorScheme.secondary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
