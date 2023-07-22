import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whopaid/widgets/elev_button_wrapper.dart';
import 'package:flutter/services.dart';
import '../../extenstion.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'change_currency.dart';
class BillScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      body: SingleChildScrollView(
        child: Consumer<Bill>(
          builder: (context, bill, _) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: calculateSize(context,48), horizontal: calculateSize(context,24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,40.0))),
                              child: InkWell(
                                onTap: (){
                                  open_ChangeCurrency(context);
                                },
                                onDoubleTap: () {
                                  bill.billUpdate();
                                  },
                                child: Container(
                                  constraints: BoxConstraints(minWidth: calculateSize(context,250), maxHeight: calculateSize(context,1000)),
                                  color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(calculateSize(context,12.0)),
                                    child: AutoSizeText(
                                      bill.billText,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.84),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: calculateSize(context,10),
                        right: calculateSize(context,10),
                        child: ElevButtonWrapper(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: bill.billText));
                          },
                          child: Icon(Icons.copy, size: calculateSize(context,30)),
                          customcolor: Theme.of(context).shadowColor.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: calculateSize(context,8.0)),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevButtonWrapper(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AutoSizeText(maxLines: 1,S.of(context).ok),
                          ),
                        ),
                        ElevButtonWrapper(
                          onPressed: () {
                            bill.saveToHistory();
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          },
                          child: Icon(Icons.menu_open, size: calculateSize(context,40)),
                          customcolor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
