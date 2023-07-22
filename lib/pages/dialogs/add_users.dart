import 'package:flutter/material.dart';
import 'package:whopaid/widgets/textfieldwrapper.dart';
import 'package:whopaid/generated/l10n.dart';
import '../../extenstion.dart';
import '../../main.dart';
import '../../widgets/elev_button_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
List<String> UserList(String line) {
  List<String> userikolist = line.split(' ');

  for (int i = 0; i< userikolist.length; i++) {
    userikolist[i] = (i+1).toString() + ". " + userikolist[i];
  }
  return userikolist;
}

void add_users_panel(BuildContext context) {
  TextEditingController textFieldController = TextEditingController(); // Create a controller

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,30.0))),
      ),
      shadowColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.all(calculateSize(context,18.0)),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,50.0))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(calculateSize(context,8.0)),
                child: AutoSizeText(maxLines: 1,
                  S.of(context).useradd1,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: calculateSize(context,8.0), vertical: calculateSize(context,4.0)),
                child: Opacity(
                  opacity: 0.8,
                  child: AutoSizeText(maxLines: 1,
                    S.of(context).useradd2,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(calculateSize(context,8.0)),
                child: TextFieldWrapper(
                  hint: S.of(context).useradd3,
                  type: TextFieldType.text,
                  controller: textFieldController, // Associate the controller with the TextFieldWrapper
                ),
              ),

              //next-button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  ElevButtonWrapper(
                    onPressed: () {
                      String inputText = textFieldController.text; // Get the value from the TextField

                      Provider.of<Bill>(context,listen: false).usersListAddElements(UserList(inputText)); // Use the obtained value
                      Navigator.pop(context);

                      Navigator.pushNamedAndRemoveUntil(context, '/users',(route)=>false);//,(route)=>false);
                    },
                    child: Icon(Icons.navigate_next, size: calculateSize(context,40)),
                    customcolor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
