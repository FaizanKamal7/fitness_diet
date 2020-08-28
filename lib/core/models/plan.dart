
class Plan {
  String planID;
  String custId; //foreign key
  String custGender;
  double custHeight;
  double custWeight;
  double custGoalWeight;

  double custReqKcal;
  double custGainKcal;
  double custburntKcal;

  double custReqProtein;
  double custGainedProtein;
  double custburntProtein;

  double custReqFats;
  double custGainedFats;
  double custBurntFats;

  double custReqCarbs;
  double custGainedCarbs;
  double custBurntCarbs;

  Plan({
    this.planID,
    this.custId,
    this.custGender,
    this.custHeight,
    this.custWeight,
    this.custGoalWeight,
    this.custReqKcal,
    this.custGainKcal,
    this.custburntKcal,
    this.custReqProtein,
    this.custGainedProtein,
    this.custburntProtein,
    this.custReqFats,
    this.custGainedFats,
    this.custBurntFats,
    this.custReqCarbs,
    this.custGainedCarbs,
    this.custBurntCarbs,
  });
}
