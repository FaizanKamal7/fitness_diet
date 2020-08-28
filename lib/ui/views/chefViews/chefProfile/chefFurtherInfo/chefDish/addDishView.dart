import 'dart:io';
// import 'package:image_cropper/image_cropper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';

import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/addDishViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/standardBtnBlueRound.dart';
import 'package:fitness_diet/ui/widgets/standardHeaderWithWhiteBG.dart';

import 'package:fitness_diet/ui/widgets/standardHeadingNoBgUniSan.dart';
import 'package:fitness_diet/ui/widgets/textFeildBigWhiteBG.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart'; // For Image Picker

class AddDish extends StatefulWidget {
  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  String _dishCatg;
  int _prepTimeHrs, _prepTimeMin, _totalPrepTime;
  File _dishPic;
  TextEditingController _dishNameContr = TextEditingController();
  TextEditingController _priceContr = TextEditingController();
  TextEditingController _attrContr = TextEditingController();

  String uploadedFileURL;
  String dropdownValue = 'Select Category';
  Size deviceSize;
  bool isNextPressed = false;
  int pageIndex;
  List screenList;
  // SwiperController _swipeController = SwiperController();
  List<DishCategory> _dishCatgList;
  List<Dish> _chefdishTemp;
  List<String> _CtgNames = List<String>();
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    _chefdishTemp = Provider.of<List<Dish>>(context);
    _dishCatgList = Provider.of<List<DishCategory>>(context);

    print(">>>>>>>>>>> Dish Category list : " + _dishCatgList.toString());
    print(">>>>>>>>>>> Dish  list : " + _chefdishTemp.toString());

    // for (int i = 0; i < _dishCatgList.length; i++) {
    //   _CtgNames.add(_dishCatgList[i].ctgName);
    //   print(_dishCatgList[i].ctgName);
    // }

    // _chefdishTemp.map((value) {
    //   _CtgNames.add(value.dishName);
    //   print("Val $value : " + value.dishName);
    // }).toList();

    print(">>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Dish Names list : " + _CtgNames.toString());

    screenList = [screen1View(deviceSize), screen2View(deviceSize)];
    return BaseView<AddDishViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) {
          return Material(
            child: Stack(
              children: <Widget>[
                //
                // >>>>>>>>>>>> Add Dish Image  <<<<<<<<<<<<<<<
                //
                Container(
                  height: widgetSize.height * 0.37,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Pick from Gallery"),
                                  onTap: () async {
                                    File dishPicTemp = await ConstantFtns()
                                        .getImgFile(
                                            ImageSource.gallery, deviceSize);
                                    print(
                                        "------- dishPicTemp inside AddDishVIew:" +
                                            dishPicTemp.toString());
                                    setState(() {
                                      _dishPic = dishPicTemp;
                                      print("------- _dishPic AddDishVIew:" +
                                          dishPicTemp.toString());
                                    });
                                  },
                                ),
                                ListTile(
                                  title: Text("Take a Picture"),
                                  onTap: () async {
                                    File dishPicTemp = await ConstantFtns()
                                        .getImgFile(
                                            ImageSource.camera, deviceSize);

                                    setState(() {
                                      _dishPic = dishPicTemp;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      // ---- Setting dish pic if not null
                      child: Stack(
                        children: <Widget>[
                          _dishPic != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(_dishPic.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: widgetSize.width * 0.33,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(widgetSize.width * 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Add Image ",
                                    style: TextStyle(
                                        fontSize: widgetSize.height * 0.02),
                                  ),
                                  Icon(
                                    Icons.add_a_photo,
                                    size: widgetSize.height * 0.028,
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                // >>>>>>>>>>>> A D D   N E W   D I S H   H E A D E R <<<<<<<<<<<<<<<
                //
                StandardHeaderWithWhiteBG(passedText: "Add new dish"),
                // --------------------------------------- A D D   D I S H   I N F O   C O L U M N
                Container(
                  // alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: widgetSize.height * 0.28),

                  //   height: widgetSize.height * 0.8,
                  width: widgetSize.width,
                  decoration: BoxDecoration(
                    color: Color(0xffe4d7cb),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(widgetSize.width * 0.18),
                    ),
                  ),
                  child: Swiper(
                    loop: false,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: deviceSize.height * 0.05),
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey,
                        activeColor: Colors.black,
                        size: widgetSize.height * 0.012,
                        activeSize: widgetSize.height * 0.015,
                      ),
                    ),
                    itemCount: 2,
                    onIndexChanged: (int _pgInd) =>
                        setState(() => pageIndex = _pgInd),
                    itemBuilder: (context, index) {
                      return screenList[index];
                    },
                  ),
                ),

                // --------------------------------------- B L U E   B U T T O N
                pageIndex == 1
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: deviceSize.height * 0.02),
                          child: FlatButton(
                              onPressed: () async {
                                print(
                                    "------ _dishPic inside onPressed  of addDishView.dart : " +
                                        _dishPic.toString());
                                model.uploadDishInfo(
                                  _dishNameContr.text,
                                  _priceContr.text,
                                  _totalPrepTime,
                                  _dishPic,
                                  _dishCatg,
                                  _attrContr.text,
                                );
                              },
                              child:
                                  StandardBtnBlueRound(passedText: "Upload")),
                        ),
                      )
                    : Container(),

                model.hasErrorMessage
                    ? Container(
                        child: Text(model.errorMessage),
                      )
                    : Container(),
                model.state == ViewState.Busy ? Loading() : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showDropDown(dynamic _passedInfo, Size deviceSize) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(deviceSize.height * 0.15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
        height: deviceSize.height * 0.05,
        width: deviceSize.width * 0.9,
        color: Colors.white.withOpacity(0.7),
        child: Center(
          child: DropdownButton<String>(
            value: dropdownValue,
            // icon: Icon(Icons.arrow_downward),
            //iconSize: 24,
            elevation: 16,
            style: TextStyle(
                color: Colors.brown.withOpacity(0.8),
                fontSize: deviceSize.height * 0.02),

            underline: Container(height: 0),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                newValue != "Select Category"
                    ? _dishCatg = newValue
                    : _dishCatg = null;
                dropdownValue = newValue;
                print("Changed value: " + _passedInfo.toString());
              });
            },
            items: <String>['Select Category', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void hoursButtomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: deviceSize.height / 3,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 1,
            secondInterval: 1,
            //    initialTimerDuration: initialtimer,
            onTimerDurationChanged: (Duration changedtimer) {
              setState(
                () {
                  _prepTimeHrs = changedtimer.inHours;
                  _totalPrepTime = changedtimer.inMinutes;
                  _prepTimeMin = changedtimer.inMinutes - _prepTimeHrs * 60;
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget screen2View(Size deviceSize) {
    return Container(
      padding: EdgeInsets.only(
        left: deviceSize.width * 0.04,
        top: deviceSize.height * 0.04,
        right: deviceSize.height * 0.04,
        bottom: deviceSize.height * 0.07,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StandardHeadingNoBgUniSans(passedText: "Ingredients:"),
            showDropDown("sa", deviceSize),
            //     SingleChildScrollView(child: children,)
          ],
        ),
      ),
    );
  }

  Widget screen1View(Size deviceSize) {
    var _currencies = [
      "Food",
      "Transport",
      "Personal",
      "Shopping",
      "Medical",
      "Rent",
      "Movie",
      "Salary"
    ];
    String _currentSelectedValue;
    return Container(
      padding: EdgeInsets.only(
        left: deviceSize.width * 0.04,
        top: deviceSize.height * 0.04,
        right: deviceSize.height * 0.04,
        bottom: deviceSize.height * 0.07,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            // >>>>>>>>>>>> D I S H   N A M E <<<<<<<<<<<<<<<
            //

            StandardHeadingNoBgUniSans(passedText: "Dish name: "),
            TextFeildBigWhiteBG(
                controller: _dishNameContr,
                deviceSize: deviceSize,
                isTypeInt: false,
                hintText: '',
                isObscureText: false),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> P R I C E <<<<<<<<<<<<<<<
            //
            Row(
              children: <Widget>[
                StandardHeadingNoBgUniSans(passedText: "Price: "),
                Text(
                  "(Rs)",
                  style: TextStyle(
                    fontFamily: "Uni-Sans",
                    fontSize: deviceSize.height * 0.019,
                    color: Color(0xff2a6427).withOpacity(0.7),
                  ),
                )
              ],
            ),
            TextFeildBigWhiteBG(
                controller: _priceContr,
                deviceSize: deviceSize,
                isTypeInt: true,
                hintText: '',
                isObscureText: false),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> P E R P   T I M E <<<<<<<<<<<<<<<
            //
            StandardHeadingNoBgUniSans(passedText: "Preperation time:"),

            Container(
              alignment: Alignment.center,
              child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // >>>>>>>>>>>> Hours
                  InkResponse(
                    onTap: () => hoursButtomSheet(context),
                    child: Container(
                      height: deviceSize.height * 0.045,
                      width: deviceSize.height * 0.063,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _prepTimeHrs == null ? "HH" : _prepTimeHrs.toString(),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: deviceSize.height * 0.024,
                            color: Color(0xff4d3814).withOpacity(0.36),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: deviceSize.height * 0.04),
                  ),
                  // >>>>>>>>>>>> Minutes
                  InkResponse(
                    onTap: () => hoursButtomSheet(context),
                    child: Container(
                      height: deviceSize.height * 0.045,
                      width: deviceSize.height * 0.063,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _prepTimeMin == null ? "MM" : _prepTimeMin.toString(),
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: deviceSize.height * 0.024,
                            color: Color(0xff4d3814).withOpacity(0.36),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> C A T E G O R Y <<<<<<<<<<<<<<<
            //
            StandardHeadingNoBgUniSans(passedText: "Category: "),
            showDropDown(_dishCatg, deviceSize),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            //
            // >>>>>>>>>>>> A T T R I B U T E S <<<<<<<<<<<<<<<
            //
            Row(
              children: <Widget>[
                StandardHeadingNoBgUniSans(passedText: "Attributes: "),
                Flexible(
                  child: Text(
                    " (Any special offer or discount)",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: "Uni-Sans",
                      fontSize: deviceSize.height * 0.013,
                      color: Color(0xff2a6427).withOpacity(0.7),
                    ),
                  ),
                )
              ],
            ),

            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(deviceSize.height * 0.15),
              ),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
                height: deviceSize.height * 0.06,
                width: deviceSize.width * 0.9,
                color: Colors.white.withOpacity(0.7),
                alignment: Alignment.topCenter,
                // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(child: TextField(controller: _attrContr)),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _attrContr.text = value;
                            print("_attrContr [[[[[[[[[[[[[[[[[[[[[[[[[[[[[ " +
                                _attrContr.text);
                          },
                          itemBuilder: (BuildContext context) {
                            return <String>[
                              'Select Category',
                              'Two',
                              'Free',
                              'Four'
                            ].map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                  child: Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // DropdownSearch<String>(
            //   mode: Mode.MENU,
            //   showSelectedItem: true,
            //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
            //   label: "Menu mode",
            //   hint: "country in menu mode",
            //   popupItemDisabled: (String s) => s.startsWith('I'),
            //   onChanged: print,
            //   selectedItem: "Brazil",
            // ),
            // TextFeildBigWhiteBG(
            //   controller: _attrContr,
            //   deviceSize: deviceSize,
            //   isTypeInt: false,
            //   hintText: '',
            //   isObscureText: false,
            // ),

            // SearchableDropdown.single(
            //   items: <String>['Select Category', 'Two', 'Free', 'Four']
            //       .map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   value: "selectedValue",
            //   hint: "Select one",
            //   searchHint: "Select one",
            //   onChanged: (value) {
            //     setState(() {
            //       _currentSelectedValue = value;
            //     });
            //   },
            //   isExpanded: true,
            // ),

            SizedBox(
              height: deviceSize.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
