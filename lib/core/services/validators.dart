class Validators {
  bool verifyNameInputFeild(String inputText) {
    return inputText != null && inputText.length < 40 && inputText != ""
        ? true
        : false;
  }

  bool verifyPhoneNumber(String phoneNumber) {
    if (phoneNumber != "") {
      if (phoneNumber[0] == "0" &&
          phoneNumber[1] == "3" &&
          phoneNumber.length == 11) {
        print("Phone Number verified (Via constant function)");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
