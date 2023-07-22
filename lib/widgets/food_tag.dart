import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:whopaid/widgets/food_widget.dart';
import 'package:whopaid/widgets/search_field_wrapper.dart';
import '../dishes.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../main.dart';

Future<String> getRandomImage() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final manifest = json.decode(manifestContent) as Map<String, dynamic>;
  final imagePaths = manifest.keys.where((String key) => key.startsWith('assets/')).toList();
  String fileName = imagePaths[Random().nextInt(imagePaths.length)].split('/').last;
  fileName = fileName.substring(0, fileName.lastIndexOf('.'));
  return fileName;
}

class FoodTag extends StatefulWidget {
  final double? height;
  final String? sometext;
  final int? somecost;

  FoodTag({
    Key? key,
    required this.sometext,
    this.height, this.somecost,
  }) : super(key: key);

  @override
  _FoodTagState createState() => _FoodTagState();
}

Future<List<dynamic>?> openChangeMenu(BuildContext context, String _displayText, String _displayNumb) async {
  String? userToDo = _displayText;
  String? userCost = _displayNumb;
  await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,22.0)))),
        shadowColor: Theme.of(context).primaryColor,
        title: AutoSizeText(maxLines: 1,
          S.of(context).food_str,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SFieldWrapper(
              suggestions: S.of(context).local == "ru" ? commonDishesListRU : S.of(context).local == "ua" ? commonDishesListUA : commonDishesListEN,
              hinttext: S.of(context).ate,
              onChanged: (String value) {
                userToDo = value;
              },
              innerText: _displayText,
            ),
            SFieldWrapper(
              suggestions: [],
              hinttext: S.of(context).cost,
              onChanged: (String value) {
                userCost = value;
              },
              isInteger: 1,
              innerText: _displayNumb,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, userToDo! + ',' + userCost!);
            },
            child: AutoSizeText(maxLines: 1,S.of(context).add),
          ),
        ],
      );
    },
  );

  return [userToDo! + ',' + userCost!];
}

class _FoodTagState extends State<FoodTag> {
  String _userToDo = "";
  late String _displayText;
  late String _displayNumb;
  late String _randomImage;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _displayText = widget.sometext ?? "";
    _displayNumb = widget.somecost!.toString() ?? "";
    _randomImage = "";
    _loadRandomImage();
  }

  Future<void> _loadRandomImage() async {
    if (_randomImage.isEmpty) {
      _randomImage = await getRandomImage();
      setState(() {}); // Update the state to trigger a rebuild and display the loaded image
    }
  }

  @override
  Widget build(BuildContext context) {
    double? _inheight = calculateSize(context,125);
    if (widget.height != null) _inheight = widget.height;

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _isMenuOpen = _displayText.isNotEmpty || _displayNumb.isNotEmpty;
      });
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.only(top: calculateSize(context,3.0),left: calculateSize(context,3.0),
              right: 0.0,bottom: calculateSize(context,3.0)),
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          child: Padding(
            padding: EdgeInsets.only(top: calculateSize(context,2.0),left: calculateSize(context,2.0),right: 0.0,bottom: calculateSize(context,2.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(calculateSize(context,30)), bottomLeft: Radius.circular(calculateSize(context,30))),
              child: InkWell(
                onTap: () async {
                  final result = await openChangeMenu(context, _displayText, _displayNumb);
                  if (result != null && result.isNotEmpty) {
                    setState(() {
                      final resultik = result[0].toString().split(',');
                        Provider.of<Bill>(context, listen: false).foodChange(_displayText,resultik[0],resultik[1]);
                      _displayText = resultik[0];
                      _displayNumb = resultik[1];
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(calculateSize(context,8)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: _isMenuOpen ? 1.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Hero(
                          tag: 'foodWidget',
                          child: _randomImage.isEmpty
                              ? Container() // Show an empty container while the image is loading
                              : FoodWidget(iconname: _randomImage, height: calculateSize(context,90)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: calculateSize(context,150)),
                            child: Padding(
                              padding: EdgeInsets.only(left: calculateSize(context,5), right: calculateSize(context,5), top: 0, bottom: calculateSize(context,4)),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  _displayText,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow:  TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: calculateSize(context,150)),
                            child: Padding(
                              padding: EdgeInsets.only(left: calculateSize(context,15)),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    AutoSizeText(maxLines: 1,
                                      _displayNumb,
                                      style: Theme.of(context).textTheme.labelSmall,
                                      softWrap: false,
                                      overflow:  TextOverflow.ellipsis, ),
                                    AutoSizeText(maxLines: 1,
                                      " ${Provider.of<Bill>(context).currency}",
                                      style: Theme.of(context).textTheme.labelSmall,
                                      softWrap: false,
                                      overflow:  TextOverflow.ellipsis, ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
