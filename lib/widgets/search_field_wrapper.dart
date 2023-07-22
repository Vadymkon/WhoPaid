import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:whopaid/widgets/texttypes.dart';

import '../extenstion.dart';

class SFieldWrapper extends StatelessWidget {
  final List<String> suggestions;
  final String? hinttext;
  final int? isInteger;
  final ValueChanged<String>? onChanged;
  final String? innerText;

  SFieldWrapper({
    Key? key,
    required this.suggestions,
    required this.hinttext,
    required this.onChanged,
    this.isInteger,
    this.innerText,
  }) : super(key: key);

  String? _selectedFood;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: calculateSize(context,5)),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(calculateSize(context,10)),
        boxShadow: [BoxShadow(
          color: Theme.of(context).scaffoldBackgroundColor,
          blurRadius: calculateSize(context,10),
          offset: Offset(0,calculateSize(context,10))
        )]
      ),
      child: EasyAutocomplete(
        initialValue: innerText != null?innerText:'',
        keyboardType : isInteger==1? TextInputType.number : TextInputType.text,
        inputFormatter: isInteger==1? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'))] :<TextInputFormatter>[FilteringTextInputFormatter.deny('/')],
        onChanged: onChanged,
        inputTextStyle: headerTwo.copyWith(color: Theme.of(context).shadowColor),
        suggestionTextStyle: headerThree.copyWith(color: Theme.of(context).cardColor),
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: headerTwo.copyWith(color: Theme.of(context).shadowColor.withOpacity(0.45)),
          labelStyle: Theme.of(context).textTheme.labelSmall,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: calculateSize(context,1.0) ),
            borderRadius: BorderRadius.circular(calculateSize(context,10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.8), width: calculateSize(context,2.0) ),
              borderRadius: BorderRadius.circular(calculateSize(context,10))
          ),
        ),
      suggestions:  suggestions,
      ),
    );
  }
}
