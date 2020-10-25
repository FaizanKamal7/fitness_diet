import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: must_be_immutable
class SummaryCard extends StatefulWidget {
  Size widgetSize;

  SummaryCard(Size widgetSize) {
    this.widgetSize = widgetSize;
  }
  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  int remaningValue = 2045;
  int eatenValue = 30;
  int burnedValue = 40;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _planData = Provider.of<Plan>(context);

    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.only(
            left: widget.widgetSize.width * 0.06,
            right: widget.widgetSize.width * 0.05,
            top: widget.widgetSize.height * 0.03),
        height: widget.widgetSize.height * 0.55,
        width: widget.widgetSize.width,
        decoration: BoxDecoration(
          color: Color(0xff800080),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.widgetSize.height * 0.15),
            topRight: Radius.circular(widget.widgetSize.height * 0.05),
            bottomRight: Radius.circular(widget.widgetSize.height * 0.15),
            bottomLeft: Radius.circular(widget.widgetSize.height * 0.05),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // E A T E N --   C A LA O R I E S //
                //
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "2,455",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.widgetSize.height * 0.040,
                        color: Color(0xffd6d8ff),
                        shadows: [
                          Shadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Eaten",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.widgetSize.height * 0.040,
                        color: Color(0xffffffff),
                        shadows: [
                          Shadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //
                //
                //  R E M A I N I N G -- S L I D E R   //
                //

                Container(
                  padding: EdgeInsets.all(widget.widgetSize.height * 0.01),
                  width: widget.widgetSize.width * 0.4,
                  height: widget.widgetSize.height * 0.3,
                  child: SleekCircularSlider(
                    initialValue: _planData.custReqKcal,
                    max: _planData.custReqKcal,

                    appearance: CircularSliderAppearance(
                      angleRange: 180,
                      startAngle: 180,
                      infoProperties: InfoProperties(
                          mainLabelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              color: Color(0xffd6d8ff),
                              fontSize: widget.widgetSize.height * 0.050),
                          modifier: (percentage) {
                            final roundedValue =
                                percentage.ceil().toInt().toString();
                            return '$roundedValue ';
                          },
                          bottomLabelText: 'Remaining',
                          bottomLabelStyle: TextStyle(
                              fontFamily: "Montserrat",
                              color: Color(0xffffffff),
                              fontSize: widget.widgetSize.height * 0.045)),
                      customColors: CustomSliderColors(
                        progressBarColor: Color(0xffffffff),
                        trackColor: Color(0xffd6d8ff),
                        dotColor: Colors.transparent,
                      ),
                      customWidths: CustomSliderWidths(
                        progressBarWidth: widget.widgetSize.height * 0.02,
                        trackWidth: widget.widgetSize.height * 0.01,
                      ),
                    ),
                    // onChange: (v) {},
                  ),
                ),

                //
                // B U R N E D  --   C A LA O R I E S //
                //
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "2,455",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.widgetSize.height * 0.040,
                        color: Color(0xffd6d8ff),
                        shadows: [
                          Shadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Burned ",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: widget.widgetSize.height * 0.040,
                        color: Color(0xffffffff),
                        shadows: [
                          Shadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                //C  A  R  B  S -- C O N T A I N E R
                //
                ///
                caloriesContainer(
                    'Carbs',
                    model.getCarbsVlaue(_planData.custReqKcal).round(),
                    widget.widgetSize),
                //
                //P R  O  T  E  I  N -- C O N T A I N E R
                //
                caloriesContainer(
                    'Protein',
                    model.getProteinvalue(_planData.custReqKcal).round(),
                    widget.widgetSize),
                //
                // F A T S -- C O N T A I N E R
                //
                caloriesContainer(
                    'Fats',
                    model.getFatsValue(_planData.custReqKcal).round(),
                    widget.widgetSize),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget caloriesContainer(String heading, int value, Size widgetSize) {
  return Container(
    height: widgetSize.height * 0.18,
    width: widgetSize.width * 0.2,
    child: Column(
      children: [
        //
        // C A R B S -- C O N T A I N E R
        //
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: widgetSize.height * 0.040,
            color: Color(0xffd6d8ff),
          ),
        ),
        LinearProgressIndicator(
          value: (value * 0.5) / value,
          backgroundColor: Color(0xffd6d8ff),
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xffffffff),
          ),
        ),
        Text(
          "123 / $value g",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: widgetSize.height * 0.035,
            color: Color(0xffe4d7cb),
          ),
        )
      ],
    ),
  );
}
