import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class TextFeildWithPrefix extends StatefulWidget {
  final TextEditingController controller;
  final Size deviceSize;
  final isTypeInt;
  final IconData preIcon;
  final hintText;

  TextFeildWithPrefix({
    @required this.controller,
    @required this.deviceSize,
    @required this.isTypeInt,
    @required this.preIcon,
    @required this.hintText,
  });
  @override
  _TextFeildWithPrefixState createState() => _TextFeildWithPrefixState();
}

class _TextFeildWithPrefixState extends State<TextFeildWithPrefix> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(widget.deviceSize.height * 0.15)),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: widget.deviceSize.width * 0.02),
        height: widget.deviceSize.height * 0.05,
        width: widget.deviceSize.width * 0.9,
        color: Colors.white.withOpacity(0.7),
        child: Center(
          child: TextField(
            keyboardType: widget.isTypeInt == true
                ? TextInputType.number
                : TextInputType.text,
            style: TextStyle(fontSize: widget.deviceSize.height * 0.025),
            controller: widget.controller,
            obscureText: false,
            cursorColor: Colors.brown,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.brown.withOpacity(0.8),
                fontSize: widget.deviceSize.height * 0.02,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.deviceSize.height * 0.15),
               // borderSide: BorderSide(color: Colors.brown, width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.deviceSize.height * 0.15),
             //   borderSide: BorderSide(color: Colors.brown, width: 0.3),
              ),
              prefixIcon: Container(
                width: widget.deviceSize.width * 0.08,
                child: IconButton(
                  color: Colors.black.withOpacity(0.5),
                  icon: Icon(
                    widget.preIcon,
                    size: widget.deviceSize.height * 0.025,
                    color: Colors.brown.withOpacity(0.7),
                  ),
                  onPressed: () {},
                ),
              ),
              //
              // >>>>>>>>> Phone Error Display
              //
            ),
          ),
        ),
      ),
    );
  }
}
