import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';

import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../main.dart';

class FoodWidgetChoosable extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? iconname;
  final Color? customcolor;
  final Color? innercolor;
  final double? height;

  FoodWidgetChoosable({
    Key? key,
    required this.iconname,
    this.customcolor,
    this.innercolor,
    this.onPressed,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? _inheight = calculateSize(context,432/3.456);
    if (height != null) _inheight = height;
    Color? _colorin = Theme.of(context).shadowColor;
    Color? _innercolorin = Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9);
    if (customcolor != null) _colorin = customcolor;
    if (innercolor != null) _innercolorin = innercolor;
    return ColorFiltered(
    colorFilter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor.withOpacity(0.05), BlendMode.softLight),
      child: Container(
      height: _inheight,
      child: Padding(
        padding: EdgeInsets.all(calculateSize(context,8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(calculateSize(context,30.0)),
          child: Container(
            color: _colorin?.withOpacity(0.9),
            padding: EdgeInsets.all(calculateSize(context,6)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(calculateSize(context,30.0)),
              child: Container(
                color: _colorin?.withOpacity(0.1),
                padding: EdgeInsets.all(calculateSize(context,4)),
                height: calculateSize(context,95),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(calculateSize(context,30.0)),
                  child: GestureDetector(
                    onTap: () {
                      print("Container clicked");
                      onPressed?.call(); // Вызываем функцию onPressed с помощью call()
                      if (onPressed == null) Navigator.pop(context, [iconname,customcolor]);
                    },
                    child: Container(
                      color: _colorin,
                      padding: EdgeInsets.all(calculateSize(context,4)),
                      height: calculateSize(context,90),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/$iconname.png'),
                        color: _innercolorin,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),);
  }
}

Future<List<String>> getImagePathsFromAssets() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final manifest = json.decode(manifestContent) as Map<String, dynamic>;
  final imagePaths = manifest.keys.where((String key) => key.startsWith('assets/')).toList();
  return imagePaths;
}

Future<List<dynamic>?> openChooseMenu(BuildContext context) async {
  final imageFiles = await getImagePathsFromAssets();
  final selectedIconname = await showDialog<List<dynamic>>(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,40.0))),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(maxLines: 1,
                S.of(context).food,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: calculateSize(context,8),
                runSpacing: calculateSize(context,8),
                children: imageFiles.map((file) {
                  final fileName = file.split('/').last;
                  final iconName = fileName.substring(0, fileName.lastIndexOf('.'));
                  final randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

                  return FoodWidgetChoosable(
                    iconname: iconName,
                    height: calculateSize(context,100),
                    customcolor: randomColor,
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: AutoSizeText(maxLines: 1,
                  'Close',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return selectedIconname;
}

class FoodWidget extends StatefulWidget {
  final String? iconname;
  final Color? customcolor;
  final Color? innercolor;
  final double? height;

  FoodWidget({
    Key? key,
    this.iconname,
    this.customcolor,
    this.innercolor,
    this.height,
  }) : super(key: key);

  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  String? iconname;
  Color? customcolor;
  double? height;

  @override
  void initState() {
    super.initState();
    iconname = widget.iconname;
    customcolor= widget.customcolor;
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    Color? _colorin = Theme.of(context).shadowColor;
    Color? _innercolorin =
    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9);
    if (widget.customcolor != null) _colorin = widget.customcolor;
    if (widget.innercolor != null) _innercolorin = widget.innercolor;

    return FoodWidgetChoosable(
      iconname: iconname != null?iconname:'pizza',
      customcolor: customcolor,
      innercolor: widget.innercolor,
      height: height,
      onPressed: () async {
        final selectedIconname = await openChooseMenu(context);
        if (selectedIconname != null) {
          setState(() {
            iconname = selectedIconname[0];
            customcolor = selectedIconname[1];
          });
        }
      },
    );
  }
}
