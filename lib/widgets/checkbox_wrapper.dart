import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckboxWrapper extends StatefulWidget {
  final VoidCallback? onChanged;
  final double checkboxSize;

  CheckboxWrapper({
    Key? key,
    this.onChanged,
    this.checkboxSize = 24.0, // Default checkbox size
  }) : super(key: key);

  @override
  _CheckboxWrapperState createState() => _CheckboxWrapperState();
}

class _CheckboxWrapperState extends State<CheckboxWrapper> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
          if (widget.onChanged != null) {
            widget.onChanged!();
          }
        },
        child: Transform.scale(
          scale: widget.checkboxSize / 24.0, // Scale factor based on desired checkbox size
          child: Checkbox(
            checkColor: Colors.transparent,
            value: _isChecked,
            onChanged: (newBool) {
              setState(() {
                _isChecked = newBool!;
              });
              if (widget.onChanged != null) {
                widget.onChanged!();
              }
            },
            activeColor: Colors.green,

          ),
        ),
      ),
    );
  }

  bool isChecked() {
    return _isChecked;
  }
}
