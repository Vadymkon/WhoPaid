import 'package:flutter/material.dart';
import 'package:whopaid/widgets/textfieldwrapper.dart';
import '../../extenstion.dart';
import '../../main.dart';
import '../../widgets/checkbox_wrapper.dart';
import 'package:whopaid/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import '../../widgets/dropdown_wrapper.dart';
import '../../widgets/elev_button_wrapper.dart';
import '../../widgets/search_field_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (await canLaunch(_url.toString())) {
    await launch(_url.toString());
  } else {
    throw Exception('Could not launch $_url');
  }
}

void openSettings(BuildContext context) {


  //TextEditingController textEditingController = TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,22.0)))),
        shadowColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(calculateSize(context,18.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: calculateSize(context,260.0)),
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
                Center(
                  child: AutoSizeText(maxLines: 1,S.of(context).themei,style: Theme.of(context).textTheme.labelMedium),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: calculateSize(context,120.0)),
                      child: ElevButtonWrapper(onPressed: () {
                        AdaptiveTheme.of(context).setDark();
                      }, child: AutoSizeText(maxLines: 1,S.of(context).darkThemeSh)),
                    ),

                    Container(
                      constraints: BoxConstraints(maxWidth: calculateSize(context,120.0)),
                      child: ElevButtonWrapper(onPressed: () {
                        AdaptiveTheme.of(context).setLight();
                      }, child: AutoSizeText(maxLines: 1,S.of(context).lightThemeSh)),
                    ),

                  ],
                ),
                ElevButtonWrapper(onPressed: () async {
                  await _launchUrl('https://play.google.com/store/games?');
                }, child: AutoSizeText(maxLines: 1,S.of(context).pro)),
                ElevButtonWrapper(onPressed: () async {
                  await _launchUrl('http://surl.li/iwmvr');
                }, child: AutoSizeText(maxLines: 1,S.of(context).donat)),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: AutoSizeText(maxLines: 1,S.of(context).close,style: Theme.of(context).textTheme.labelSmall),
                ),
              ],
            ),))
    ),

  );
}