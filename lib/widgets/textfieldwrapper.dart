import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../extenstion.dart';

enum TextFieldType {
  text,
  integer,
}
class TextFieldWrapper extends StatelessWidget {
  final String? sometext;
  final String? hint;
  final TextFieldType type;
  final Function(String)? onChanged;
  final TextEditingController? controller;


  TextFieldWrapper({
    Key? key,
    required this.type,
    this.sometext,
    this.hint,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
          return AdaptiveTextSelectionToolbar(
            anchors: editableTextState.contextMenuAnchors,
            children: editableTextState.contextMenuButtonItems.map((ContextMenuButtonItem buttonItem) {
              return CupertinoButton(
                borderRadius: null,
                onPressed: buttonItem.onPressed,
                padding: EdgeInsets.all(calculateSize(context,10.0)),
                pressedOpacity: 0.7,
                child: SizedBox(
                  width: calculateSize(context,200.0),
                  child: AutoSizeText(maxLines: 1,
                    CupertinoTextSelectionToolbarButton.getButtonLabel(context, buttonItem),
                    style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                  ),),); }).toList(),);},
        style: Theme.of(context).textTheme.labelSmall,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.titleSmall,
          labelText: sometext,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        keyboardType: type == TextFieldType.integer ? TextInputType.number : null,
        inputFormatters: type == TextFieldType.integer ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[\d\s]*$'))] : null,
      ),
    );
  }
}
