import 'package:flutter/material.dart';
import 'package:whopaid/generated/l10n.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../extenstion.dart';
import '../../widgets/elev_button_wrapper.dart';

void errorMessage(BuildContext context, String errorMessage) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,22.0)))),
        shadowColor: Theme.of(context).primaryColor,
        child: Padding(
            padding: EdgeInsets.all(calculateSize(context,18.0)),
            child: Container(
              width: calculateSize(context,260.0),
              // height: 230.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius:
                new BorderRadius.all(new Radius.circular(calculateSize(context,50.0))),
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(maxLines: 3,errorMessage ,style: Theme.of(context).textTheme.labelMedium),
                        ElevButtonWrapper(onPressed: () {
                          Navigator.pop(context);
                        }, child: AutoSizeText(maxLines: 1,S.of(context).ok)),
              ]

    ),))));
}