import 'package:flutter/material.dart';

class AddExerciseView extends StatefulWidget {
  @override
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

var _controller = TextEditingController();

class _AddExerciseViewState extends State<AddExerciseView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: deviceSize.height * 0.15,
          width: double.infinity,
          color: Colors.pinkAccent,
          child: Center(
            child: Container(
              width: deviceSize.width * 0.9,
              height: deviceSize.height * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(deviceSize.height * 0.1))),
              child: TextFormField(
                style: TextStyle(color: Colors.black), // Text written color
                controller: _controller,
                cursorColor: Colors.black,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  // floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: Colors.white,
                  hintText: "What are you looking for?",

                  //
                  // >>>>>>>>> S E A R C H   I C O N
                  //
                  prefixIcon: IconButton(
                    hoverColor: Colors.brown,
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceSize.width * 0.03),
                    color: Colors.black.withOpacity(0.5),
                    icon: Icon(
                      Icons.search,
                      size: deviceSize.height * 0.03,
                    ),
                    onPressed: () {
                      // Search functionality here
                    },
                  ),
                  //
                  // >>>>>>>>> F i l t e r  I C O N
                  //
                  // suffixIcon: IconButton(
                  //   hoverColor: Colors.brown,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: deviceSize.width * 0.06),
                  //   color: Colors.black.withOpacity(0.8),
                  //   icon: Icon(
                  //     Icons.filter_list,
                  //     size: deviceSize.height * 0.06,
                  //   ),
                  //   onPressed: () => _controller.clear(),
                  // ),

                  //______ To adjust label hist text to top
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(3),
                  //   borderSide: BorderSide(
                  //       color: Colors.brown,
                  //       width: 0.07,
                  //       style: BorderStyle.solid),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
