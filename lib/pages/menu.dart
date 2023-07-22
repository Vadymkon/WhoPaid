import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whopaid/pages/dialogs/add_users.dart';
import 'package:whopaid/widgets/elev_button_wrapper.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../widgets/search_field_wrapper.dart';
import 'dialogs/change_currency.dart';
import 'dialogs/settings.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Provider.of<Bill>(context).vmin/

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Bill>(context).usetip = S.of(context).usetip;
    Provider.of<Bill>(context).bmaker1_bill = S.of(context).bmaker1_bill;
    Provider.of<Bill>(context).bmaker2_foodtitle = S.of(context).bmaker2_foodtitle;
    Provider.of<Bill>(context).bmaker3_dishestitle = S.of(context).bmaker3_dishestitle;
    Provider.of<Bill>(context).bmaker4_missed = S.of(context).bmaker4_missed;
    Provider.of<Bill>(context).bmaker5_foodmissed = S.of(context).bmaker5_foodmissed;
    Provider.of<Bill>(context).bmaker6_guymissed = S.of(context).bmaker6_guymissed;

    return Scaffold(
        appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).menu),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
          actions: [
            IconButton(onPressed: () {openSettings(context);}, icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,))
          ],
        ),
        body:
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all( calculateSize(context,32)),
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(top: calculateSize(context,188), bottom: calculateSize(context,34)),
                      child: Column(
                        children: [
                          InkWell(
                              child: AutoSizeText(maxLines: 1,"WhoPaid",  style: Theme.of(context).textTheme.labelLarge),
                              onTap: (){
                                open_ChangeCurrency(context);
                              }),
                          AutoSizeText(maxLines: 1,S.of(context).discr,  style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                    ),

                    Container(
                      constraints: BoxConstraints(maxHeight: calculateSize(context,90)),
                      child: Opacity(
                        opacity: 0.74,
                        child: ElevButtonWrapper(onPressed: () {
                          Provider.of<Bill>(context,listen: false).clearAll();
                          Navigator.pushNamed(context, '/history');
                        }, child: AutoSizeText(maxLines: 1,S.of(context).history)),
                      ),
                    ),

                    Container(
                      constraints: BoxConstraints(minHeight: calculateSize(context,120)),
                      child: ElevButtonWrapper(onPressed: () {
                        Provider.of<Bill>(context,listen: false).clearAll();
                        add_users_panel(context);
                      }, child: AutoSizeText(maxLines: 1,S.of(context).bill)),
                    ),

                  ],),
              ),),
          ),
    );
  }
}
