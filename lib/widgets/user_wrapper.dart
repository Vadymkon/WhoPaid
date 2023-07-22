import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whopaid/widgets/search_field_wrapper.dart';
import '../extenstion.dart';
import '../generated/l10n.dart';
import '../main.dart';
import 'elev_button_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
class UserTag extends StatefulWidget {
  final double? height;
  final String? name;

  UserTag({
    Key? key,
    required this.name,
    this.height,
  }) : super(key: key);

  @override
  _UserTagState createState() => _UserTagState();
}

Future<String?> ChangeName(BuildContext context, String displayText) async {
  String? username = displayText.split('.').last;
  String? ident = displayText.split('.').first + '. ';

  await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(calculateSize(context,22.0)))),
        shadowColor: Theme.of(context).primaryColor,
        title: AutoSizeText(maxLines: 1,
          S.of(context).username,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SFieldWrapper(
              suggestions: [],
              hinttext: S.of(context).name,
              onChanged: (String value) {
                username = value;
              },
              innerText: username,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevButtonWrapper(
                onPressed: () {
                  Navigator.pop(context, ident + username!.trim());
                },
                child: AutoSizeText(maxLines: 1,S.of(context).add),
              ),
            ),
          ],
        ),
      );
    },
  );

  return ident + username!.trim();
}

class _UserTagState extends State<UserTag> {
  late String _displayText;

  @override
  void initState() {
    super.initState();
    _displayText = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double? _inheight = calculateSize(context,93);
    if (widget.height != null) _inheight = widget.height;
    int index = Provider.of<Bill>(context).users_list.indexOf(_displayText);
    return Row(
      children: [
        Expanded(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor.withOpacity(0.05), BlendMode.softLight),
            child: Container(
              height: _inheight,
              child: ElevButtonWrapper(
                customcolor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                onPressed: () {
                  Provider.of<Bill>(context,listen: false).chooseUser(_displayText);
                    Navigator.pushReplacementNamed(context, '/main_menu');
                    },
                /*
                менялка имени. была убрана из-за неинтуитивности
                async {
                  final newName = await ChangeName(context, _displayText);
                  if (newName != null) {
                    setState(() {
                      _displayText = newName;
                      Provider.of<Bill>(context,listen: false).usersListElemChange(index, _displayText);
                    });
                  }
                },

                 */
                child: AutoSizeText(maxLines: 1,_displayText),
              ),
            ),
          ),
        ),
      ],
    );
  }
}