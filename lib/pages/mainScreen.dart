import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:whopaid/widgets/elev_button_wrapper.dart';
import 'package:whopaid/widgets/textfieldwrapper.dart';
import '../dishes.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../widgets/checkbox_wrapper.dart';
import '../widgets/dropdown_wrapper.dart';
import '../widgets/food_tag.dart';
import '../widgets/food_tag_full.dart';
import '../widgets/food_widget.dart';
import '../widgets/plus_button.dart';
import '../widgets/search_field_wrapper.dart';
import 'dialogs/settings.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).menu),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(onPressed: (){;}, icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor));
          },),
          actions: [
            IconButton(onPressed: () {openSettings(context);}, icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,))
          ],
        ),
        body:
        SingleChildScrollView (child: Container(
          padding: EdgeInsets.all(calculateSize(context,25.0)),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(maxLines: 1,"WhoPaid",  style: Theme.of(context).textTheme.labelLarge),
            AutoSizeText(maxLines: 1,S.of(context).meow_message,  style: Theme.of(context).textTheme.labelMedium),
            AutoSizeText(maxLines: 1,S.of(context).template,  style: Theme.of(context).textTheme.labelSmall),
            AutoSizeText(maxLines: 1,S.of(context).template,  style: Theme.of(context).textTheme.titleSmall),

            ElevButtonWrapper(onPressed: () {
               Navigator.pushNamedAndRemoveUntil(context, '/todo',(route)=>false);
            }, child: AutoSizeText(maxLines: 1,S.of(context).tap)),

            ElevButtonWrapper(onPressed: () {
               AdaptiveTheme.of(context).setDark();
             }, child: AutoSizeText(maxLines: 1,S.of(context).darkTheme)),

            ElevButtonWrapper(onPressed: () {
              AdaptiveTheme.of(context).setLight();
            }, child: AutoSizeText(maxLines: 1,S.of(context).lightTheme)),

            //next-button
            ElevButtonWrapper(onPressed: () {
              AdaptiveTheme.of(context).setLight();
            }, child: Icon(Icons.navigate_next,size: calculateSize(context,40)),customcolor: Colors.green),

            //50% button
          Opacity(
            opacity: 0.6,
            child:ElevButtonWrapper(onPressed: () {
              AdaptiveTheme.of(context).setLight();
            }, child: Icon(Icons.navigate_next,size: calculateSize(context,40),),customcolor: Colors.green),
            ),

            TextFieldWrapper(type: TextFieldType.integer,sometext: "Value:"),
            TextFieldWrapper(type: TextFieldType.text, sometext: "Text:"),

            SFieldWrapper(suggestions: S.of(context).local == "ru" ? commonDishesListRU : S.of(context).local == "ua" ? commonDishesListUA : commonDishesListEN,hinttext: S.of(context).ate,onChanged: (String value){;},),

            CheckboxWrapper(checkboxSize: calculateSize(context,35)),

            //dialog menu
            ElevButtonWrapper(
              child: const AutoSizeText(maxLines: 1,'Show Dialog'),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                  padding: EdgeInsets.all(calculateSize(context,8.0)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CheckboxWrapper(checkboxSize: calculateSize(context,35)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: AutoSizeText(maxLines: 1,'Close',style: Theme.of(context).textTheme.labelSmall),
                        ),
                      ],
                ),)
              ),
            ),),

            FoodWidget(iconname: 'borshch',customcolor: Colors.green,),

            FoodTagFull(sometext: 'SOMETEXT',),
            FoodTagFull(sometext: 'SOMETEXT',),

            PlusButton(onPressed: (){},),

            //user-panel
            Row(
              children: [
                //кнопка юзер редакт
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,140.0))),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: calculateSize(context,300),minHeight: calculateSize(context,45)),
                  child: ElevatedButton(onPressed: (){;}, child: Row(
                    children: [
                      AutoSizeText(maxLines: 1,S.of(context).user,style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
                      Padding(
                        padding: EdgeInsets.only(left: calculateSize(context,5.5)),
                        child: Icon(Icons.edit,size: calculateSize(context,15)),
                      ),
                    ],
                  )),
                ),),
              ),

              Container(
                child: Padding(
                  padding: EdgeInsets.all(calculateSize(context,8.0)),
                  child: DropdownButtonApp(list: <String>['One', 'Two', 'Three', 'Four']),
                ),
              ),
            ],),

            //panel for check
            ClipRRect(

              borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,40.0))),
              child: InkWell(
                onTap: () {
                  ;
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: calculateSize(context,250),minHeight: calculateSize(context,200)),
                  color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(maxLines: 1,S.of(context).template,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),),
                      )),
              ),
              ),

          ],),))
    );
  }
}
