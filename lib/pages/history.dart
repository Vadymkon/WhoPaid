import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:whopaid/generated/l10n.dart';
import 'package:whopaid/main.dart';
import 'package:whopaid/pages/dialogs/add_food.dart';
import 'package:whopaid/pages/dialogs/error.dart';
import 'package:whopaid/pages/dialogs/settings.dart';
import 'package:whopaid/widgets/elev_button_wrapper.dart';
import 'package:whopaid/widgets/plus_button.dart';
import 'package:whopaid/widgets/user_wrapper.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extenstion.dart';

class History extends StatefulWidget {
  const History({Key? key,}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();

}

class _HistoryState extends State<History> {
  List<String> historyFiles = [];
  String newName = "";

  @override
  void initState() {
    super.initState();
    loadHistoryFiles();
  }

  Future<void> loadHistoryFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');
    if (await historyDirectory.exists()) {
      final files = historyDirectory.listSync();
      historyFiles = files.map((file) => file.path).toList();
      setState(() {});
    }
  }
  void deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      print('File removed: $filePath');
    } else {
      print('File is not found: $filePath');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: AutoSizeText(maxLines: 1,S.of(context).bill4),centerTitle: true,titleTextStyle: Theme.of(context).textTheme.labelMedium,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(onPressed: (){print('object');
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
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: calculateSize(context,12), left: calculateSize(context,25.0), right: calculateSize(context,25), bottom: calculateSize(context,25)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(maxLines: 1,S.of(context).taptip2, style: Theme.of(context).textTheme.labelSmall),
                AutoSizeText(maxLines: 1,S.of(context).swipetip, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: calculateSize(context,20)),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final file = File(historyFiles[index]);
                      final fileName = file.path.split('/').last;

                      return Dismissible(
                          onDismissed: (direction){
                            final filePath = historyFiles[index];
                            deleteFile(filePath);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AutoSizeText(maxLines: 1,S.of(context).file_removed),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        key:  Key(historyFiles[index]),
                        child: ElevButtonWrapper(
                          onPressed: () async {
                            final data = await file.readAsString();
                            Provider.of<Bill>(context, listen: false).loadFromHistoryData(data);

                          },
                          child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(maxLines: 1, S.of(context).bill3 + ' ${index + 1}',),

                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(calculateSize(context,8.0)),
                                  child: AutoSizeText(maxLines: 1,
                                    Provider.of<Bill>(context).getTotalCost(file.path),
                                  ),
                                ),
                                Icon(Icons.next_plan,size: calculateSize(context,40),),
                              ],
                            )
                          ],
                        ),)
                      );
                    }),
              ]),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(calculateSize(context,30)),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevButtonWrapper(
                onPressed: () {
                  if (Provider.of<Bill>(context, listen: false).users_list.isNotEmpty) {
                    if (Provider.of<Bill>(context, listen: false).food.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, '/main_menu');
                    } else {
                      add_food_panel(context);
                    }
                  } else {
                    errorMessage(context, S.of(context).error1);
                  }
                },
                child: Icon(Icons.navigate_next, size: calculateSize(context,40)),
                customcolor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}