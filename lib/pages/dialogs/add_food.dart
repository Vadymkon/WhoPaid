import 'package:flutter/material.dart';
import 'package:whopaid/pages/dialogs/error.dart';
import 'package:whopaid/widgets/textfieldwrapper.dart';
import 'package:whopaid/generated/l10n.dart';
import '../../extenstion.dart';
import '../../main.dart';
import '../../widgets/elev_button_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../widgets/search_field_wrapper.dart';

List<String> UserList(String line) {
  List<String> userikolist = line.split(' ');

  for (int i = 0; i< userikolist.length; i++) {
    userikolist[i] = (i+1).toString() + ". " + userikolist[i];
  }
  return userikolist;
}

void add_food_panel(BuildContext context) {
  TextEditingController textFieldController = TextEditingController(); // Create a controller
  TextEditingController textFieldController2 = TextEditingController(); // Create a controller

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
                  S.of(context).food_str,
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
                  hint: S.of(context).foodlist,
                  type: TextFieldType.text,
                  controller: textFieldController, // Associate the controller with the TextFieldWrapper
                ),
              ),

              //part 2 cost

              Padding(
                padding: EdgeInsets.all(calculateSize(context,8.0)),
                child: AutoSizeText(maxLines: 1,
                  S.of(context).cost,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: calculateSize(context,8.0), vertical: calculateSize(context,4)),
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
                  hint: S.of(context).costlist,
                  type: TextFieldType.integer,
                  controller: textFieldController2, // Associate the controller with the TextFieldWrapper
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
                      String inputFood = textFieldController.text; // Get the value from the TextField
                      String inputCost = textFieldController2.text;


                      //обработка list-ов
                      List<String> inputFoodList = inputFood.split(' ');
                      List<String> inputCostList = inputCost.split(' ');

                      for (int i = 0; i< inputFoodList.length;i++)
                        {
                          inputFoodList[i] =  inputFoodList[i].trim();
                          if ( inputFoodList[i] == "" ||  inputFoodList[i] == null)  inputFoodList.removeAt(i);
                        }

                      for (int i = 0; i< inputCostList.length;i++)
                        {
                          inputCostList[i] =  inputCostList[i].trim();
                          if ( inputCostList[i] == "" ||  inputCostList[i] == null)  inputCostList.removeAt(i);
                        }

                      if (inputFoodList.length==inputCostList.length)
                        {
                          Provider.of<Bill>(context,listen: false).foodAddLists(inputFoodList, inputCostList ); // Use the obtained value

                          if (!Provider.of<Bill>(context,listen: false).food.isEmpty) {
                            Navigator.pop(context);

                            Navigator.pushReplacementNamed(context, '/main_menu');
                          }
                          else errorMessage(context, S.of(context).error2);
                        }
                      else
                        errorMessage(context, S.of(context).error3);
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
