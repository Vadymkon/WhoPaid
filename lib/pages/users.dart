import 'package:flutter/material.dart';
import 'package:whopaid/pages/dialogs/add_food.dart';
import 'package:whopaid/pages/dialogs/error.dart';
import 'package:whopaid/widgets/elev_button_wrapper.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../widgets/user_wrapper.dart';
import '../widgets/plus_button.dart';
import 'dialogs/settings.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Users extends StatefulWidget {
  const Users({Key? key,}) : super(key: key);

  @override
  State<Users> createState() => _UserState();

}

class _UserState extends State<Users> {

  String newName = "";

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).user),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(onPressed: (){
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                };
              }, icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor));
            },),
          actions: [
            IconButton(onPressed: () {openSettings(context);}, icon: Icon(Icons.settings, color: Theme.of(context).primaryColor,))
          ],
        ),
        body:
       SingleChildScrollView (child: Container(
          padding: EdgeInsets.only(top: calculateSize(context,12), left: calculateSize(context,25.0), right: calculateSize(context,25), bottom: calculateSize(context,25)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(maxLines: 1,S.of(context).taptip,style: Theme.of(context).textTheme.labelSmall,),
                AutoSizeText(maxLines: 1,S.of(context).swipetip,style: Theme.of(context).textTheme.titleSmall,),
                Container(
                  constraints: BoxConstraints(maxHeight: calculateSize(context,600)),
                  child: ListView.builder(itemCount: Provider.of<Bill>(context).users_list.length ,itemBuilder: (BuildContext context, int index){
                    return Dismissible( //смахивалка
                      key: Key(Provider.of<Bill>(context).users_list[index]),
                      child: UserTag(height:calculateSize(context,90),name: Provider.of<Bill>(context).users_list[index]),
                      onDismissed: (direction){
                        setState(() {
                          Provider.of<Bill>(context,listen: false).usersListRemoveByIndex(index);
                        });
                      },
                    );
                  }),
                ),
              ],),
          ),)),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            child: Container(
            padding: EdgeInsets.only(bottom: calculateSize(context,15)),
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              child: Row(
                children: [
                  ElevButtonWrapper(onPressed: () {
                    print( Provider.of<Bill>(context, listen: false).state);
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                    };
                  }, child: Icon(Icons.navigate_before,size: calculateSize(context,40)),customcolor: Colors.green),
                  PlusButton(
                      onPressed: () async {
                        newName = (await ChangeName(context, ""))!;
                        if (newName != null && newName != "") {
                          setState(() {
                            Provider.of<Bill>(context,listen: false).usersListAddElement((Provider.of<Bill>(context,listen: false).users_list.length+1).toString()+newName);
                            //print(Provider.of<Bill>(context).users_list);
                          });
                        }
                      },
                    ),

                  ElevButtonWrapper(onPressed: () {

                    if (!Provider.of<Bill>(context,listen: false).users_list.isEmpty) {
                      if (!Provider.of<Bill>(context,listen: false).food.isEmpty)
                        Provider.of<Bill>(context,listen: false).takeTemplateFood();
                      Navigator.pushReplacementNamed(context, '/main_menu');
                    }
                    else errorMessage(context, S.of(context).error1);//DIALOG;
                  }, child: Icon(Icons.navigate_next,size: calculateSize(context,40)),customcolor: Colors.green),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
