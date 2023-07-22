import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extenstion.dart';
import '../generated/l10n.dart';

//обёртка над стейтлесвиджетом и возврат кнопки
class PlusButton extends StatelessWidget {
  final VoidCallback? onPressed;

  PlusButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //buttonOrdinary = buttonOrdinary.copyWith(style);
    return Padding(
      padding: EdgeInsets.all(calculateSize(context,4.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,140.0))),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: calculateSize(context,45)),
          child: ElevatedButton(
              onPressed: onPressed,
              child: Container(
                constraints: BoxConstraints(maxWidth: calculateSize(context,200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(  constraints: BoxConstraints(maxWidth: calculateSize(context,150)),
                        child: AutoSizeText(maxLines: 1,S.of(context).add,style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),)),
                    Icon(CupertinoIcons.plus, size: calculateSize(context,35),),
                  ],
                ),
              ),style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: MaterialStateProperty.all<Color>(Colors.green.withOpacity(0.98)))),
        ),
      ),
    );
  }
}