import 'dart:io';

import 'package:flutter/material.dart';
import '../extenstion.dart';
import '../main.dart';
import 'food_tag.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodTagFull extends StatefulWidget {
  final String? sometext;
  final double? customHeight;
  final int? somecost;

  FoodTagFull({
    Key? key,
    required this.sometext,
    this.customHeight, this.somecost,
  }) : super(key: key);

  @override
  _FoodTagFullState createState() => _FoodTagFullState();
}

class _FoodTagFullState extends State<FoodTagFull> {

  @override
  Widget build(BuildContext context) {
    double? _height = calculateSize(context,115);
    if (widget.customHeight != null) _height = widget.customHeight;

   // bool isTapped = Provider.of<Bill>(context).stateReturn(widget.sometext!);
    bool isTapped = Provider.of<Bill>(context).state[Provider.of<Bill>(context).food.indexOf(widget.sometext!)][Provider.of<Bill>(context).choosenUser];
    return Padding(
      padding: EdgeInsets.only(left: 0, right: calculateSize(context,5)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: calculateSize(context,8.0)),
        child: Row(
          children: [ Container(
                height: _height,
                child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: calculateSize(context,250), maxWidth: calculateSize(context,270)),
                    child: FoodTag(sometext: widget.sometext, somecost: widget.somecost ?? 100,)),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isTapped = !isTapped;
                    Provider.of<Bill>(context, listen: false).stateChange(widget.sometext!);
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 140),
                  height: _height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(calculateSize(context,30)),
                      bottomRight: Radius.circular(calculateSize(context,30)),
                    ),
                    // isTapped?
                    color: Provider.of<Bill>(context).state[Provider.of<Bill>(context).food.indexOf(widget.sometext!)][Provider.of<Bill>(context).choosenUser] ?
                      Colors.green : Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(calculateSize(context,8.0)),
                    child: AutoSizeText(maxLines: 1,""),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
