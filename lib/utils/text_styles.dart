import 'package:flutter/material.dart';

class TextStyles {
  //private constructor
  TextStyles._();

  static final TextStyle appDateTextStyle =
      TextStyle(fontSize: 14, color: Colors.white);

  static final TextStyle appTitleTextStyle =
      TextStyle(fontSize: 18, color: Colors.white);

  static final TextStyle casesTextStyle =
      TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold);

  static final TextStyle selectCountryTextStyle =
      TextStyle(fontSize: 18, color: Colors.grey.shade700);

  static final TextStyle dropdownTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static final TextStyle dropdownItemTextStyle =
      TextStyle(fontSize: 16, color: Colors.redAccent);
  static final TextStyle countryNameTextStyle =
      TextStyle(fontSize: 24, color: Colors.white);

  static final TextStyle caseNameTextStyle =
      TextStyle(fontSize: 16, color: Colors.grey.shade600);
  static final TextStyle typeCasesTextStyle =
      TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);
  static final TextStyle typeConditionPercentageTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24);
  static final TextStyle typeConditionTextStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 16);

  static final TextStyle noStatusTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16);
  static final TextStyle statusTextStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 16);
  static final TextStyle statusLabelTextStyle =
      TextStyle(fontSize: 16, color: Colors.grey.shade600);
}
