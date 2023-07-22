import 'package:flutter/material.dart';

import '../extenstion.dart';

//просто батон-стайл
ButtonStyle buttonOrdinary = ElevatedButton.styleFrom(

  minimumSize: Size(70, 50),
  padding: EdgeInsets.all(20),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)),),
);

//обёртка над стейтлесвиджетом и возврат кнопки
class ElevButtonWrapper extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? customcolor;
  //final ButtonStyle? style;

  ElevButtonWrapper({
    Key? key,
    required this.onPressed,
    required this.child,
    this.customcolor,
    //this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //buttonOrdinary = buttonOrdinary.copyWith(style);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: calculateSize(context,8), horizontal: calculateSize(context,5)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonOrdinary.copyWith(
          minimumSize: MaterialStateProperty.all<Size>(Size(calculateSize(context,70), calculateSize(context,50))),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(calculateSize(context,20))),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,50))),),
        ),
        /*

        buttonOrdinary.copyWith(
            : buttonOrdinary.copyWith(
          */
        ).copyWith(
        backgroundColor: customcolor != null && customcolor != Theme.of(context).shadowColor ?
          MaterialStateProperty.all<Color>(customcolor!) : MaterialStateProperty.all<Color>(Theme.of(context).shadowColor) ),
        child: child,
      ),
    );
  }
}
