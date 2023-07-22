import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whopaid/pages/dialogs/add_food.dart';
import 'package:whopaid/pages/dialogs/error.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../widgets/dropdown_wrapper.dart';
import '../widgets/elev_button_wrapper.dart';
import '../widgets/food_tag.dart';
import '../widgets/food_tag_full.dart';
import '../widgets/plus_button.dart';
import 'dialogs/check.dart';
import 'dialogs/settings.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Bill>(context).isFirst || Provider.of<Bill>(context).state.isEmpty)
    {
      Provider.of<Bill>(context, listen: false).makeMatrix();
      Provider.of<Bill>(context, listen: false).isFirst = false;
    }

    return Scaffold(
        appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).bill2),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
          leading: Builder(
            builder: (BuildContext context) {
              return Row(
                children: [
                  IconButton(onPressed: (){print('object');
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, '/users',(route)=>false);
                  };
                    }, icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor)),
                ],
              );
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
              //panel for check
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,40.0))),
                      child: InkWell(
                        onTap: () {
                          Provider.of<Bill>(context, listen: false).billUpdate();
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  BillScreen()));
                        },
                        child: Container(
                            constraints: BoxConstraints(minWidth: calculateSize(context,250),maxHeight: calculateSize(context,200)),
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(calculateSize(context,12.0)),
                              child: AutoSizeText(Provider.of<Bill>(context).billText,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),
                              overflow: TextOverflow.ellipsis,maxLines: 9,),
                            )),
                      ),
                    ),
                  ),
                ],
              ),

              //user-panel
              Row(
                children: [

                  //кнопка юзер редакт
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,140.0))),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: calculateSize(context,300),minHeight: calculateSize(context,45)),
                        child: ElevatedButton(onPressed: (){

                          Navigator.pushNamedAndRemoveUntil(context, '/users',(route)=>false);
                          }, child: Row(
                          children: [
                            Container(
                                constraints: BoxConstraints(maxWidth: calculateSize(context,65)),
                                child: AutoSizeText(maxLines: 1,S.of(context).user,style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),)),
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
                      child: DropdownButtonApp(list: Provider.of<Bill>(context).users_list),
                    ),
                  ),
                ],),





              //AutoSizeText(maxLines: 1,S.of(context).meow_message,  style: Theme.of(context).textTheme.labelMedium),
              //AutoSizeText(maxLines: 1,S.of(context).taptip,style: Theme.of(context).textTheme.labelSmall,),
              //AutoSizeText(maxLines: 1,S.of(context).swipetip,style: Theme.of(context).textTheme.titleSmall,),

              SingleChildScrollView (child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Opacity(
                        opacity: 0.9,
                          child: AutoSizeText(S.of(context).taptip3,style: Theme.of(context).textTheme.labelSmall,maxLines: 2,)),
                      Container(
                        constraints: BoxConstraints(maxHeight: calculateSize(context,420)),
                        child: ListView.builder(itemCount: Provider.of<Bill>(context).food.length ,itemBuilder: (BuildContext context, int index){
                          return Dismissible( //смахивалка
                            key: Key(Provider.of<Bill>(context).food[index]),
                            child: FoodTagFull(
                              sometext: Provider.of<Bill>(context).food[index],
                              somecost: Provider.of<Bill>(context).cost[index],
                            ),
                            onDismissed: (direction){
                              //if (direction == DismissDirection.endToStart)
                              setState(() {
                                Provider.of<Bill>(context,listen: false).foodRemoveAt(Provider.of<Bill>(context,listen: false).food[index]);
                              });
                            },
                          );
                        }),
                      ),
                    ],),
                ),)),


            ],),)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,30))),
            child: Container(

              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                padding: EdgeInsets.only(bottom: calculateSize(context,15)),
                child: Row(
                  children: [
                    ElevButtonWrapper(onPressed: () {
                      print( Provider.of<Bill>(context, listen: false).state);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, '/users',(route)=>false);
                      };
                    }, child: Icon(Icons.navigate_before,size: calculateSize(context,40)),customcolor: Colors.green),
                    PlusButton(onPressed: ()
                    async {
                      final result = await openChangeMenu(context, "","");
                      //errorMessage(context, result![0].toString());
                      if (result != null && result.isNotEmpty) {
                          final resultik = result[0].toString().split(',');
                          Provider.of<Bill>(context, listen: false).foodAddLists([resultik[0]],[resultik[1]]);
                      }
                    },
                      /*
                    {

                     //add_food_panel(context);
                    },

                    */),
                    ElevButtonWrapper(onPressed: () {
                      print( Provider.of<Bill>(context, listen: false).state);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              BillScreen()));
                      }, child: Icon(Icons.navigate_next,size: calculateSize(context,40)),customcolor: Colors.green),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
