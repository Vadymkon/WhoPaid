import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extenstion.dart';
import '../main.dart';

/// Flutter code sample for [DropdownButton].

class DropdownButtonApp extends StatelessWidget {
  final List<String> list;
  const DropdownButtonApp({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonExample(list: list,);
  }
}

class DropdownButtonExample extends StatefulWidget {
  final List<String> list;
  const DropdownButtonExample({Key? key, required this.list}) : super(key: key);




  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calculateSize(context,250),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: calculateSize(context,16), vertical: calculateSize(context,12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculateSize(context,30)),
            borderSide: BorderSide(width: calculateSize(context,3), color: Theme.of(context).primaryColor),
          ),
        ),
        value:  Provider.of<Bill>(context).users_list[ Provider.of<Bill>(context).choosenUser],
        icon: Icon(Icons.expand_circle_down_rounded, color: Theme.of(context).primaryColor),
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
          setState(() {
            /**/
            dropdownValue = value!;
            Provider.of<Bill>(context, listen: false).chooseUser(dropdownValue);
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            onTap: () {
              Provider.of<Bill>(context, listen: false).chooseUser(value);
              print(Provider.of<Bill>(context, listen: false).choosenUser);
            },
            enabled: true,
            value: value,
            child: Container(
              alignment: Alignment.center,
              child: AutoSizeText(maxLines: 1,
                value,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          );
        }).toList(),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98),
      ),
    );
  }
}
