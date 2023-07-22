import 'package:flutter/material.dart';
import 'package:whopaid/generated/l10n.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import '../../extenstion.dart';
import '../../main.dart';
import '../../widgets/elev_button_wrapper.dart';
import '../../widgets/search_field_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

void open_ChangeCurrency(BuildContext context) {
  String errorMessage = S.of(context).currency ;
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
                      AutoSizeText(maxLines: 1,errorMessage ,style: Theme.of(context).textTheme.labelMedium),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(calculateSize(context,8.0)),
                            child: Container(
                              width: calculateSize(context,100),
                              child: SFieldWrapper(
                                hinttext: "USD", suggestions: ['USD','UAH','\$'],
                                onChanged: (String value) {
                                  Provider.of<Bill>(context, listen: false).currency = value;

                                  Provider.of<Bill>(context,listen: false).billUpdate();
                                  },),
                            ),
                          ),

                          ElevButtonWrapper(onPressed: () {
                            Provider.of<Bill>(context,listen: false).billUpdate();
                            Navigator.pop(context);
                          }, child: AutoSizeText(maxLines: 1,S.of(context).ok)),
                        ],
                      ),

                    ]

                ),))));
}