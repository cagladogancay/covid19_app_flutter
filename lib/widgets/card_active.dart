import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/utils/text_styles.dart';

class CardActive extends StatelessWidget {
  int todayCases;
  String caseName;
  int critical;
  int totalCases;
  int active;
  int death;
  int recovered;

  CardActive(
    this.caseName,
    this.totalCases,
    this.active,
    this.todayCases,
    this.critical,
  );

  @override
  Widget build(BuildContext context) {
    double criticalPercentage =
        double.parse(((critical * 100) / totalCases).toStringAsFixed(2));
    double mildCondition =
        double.parse((100 - criticalPercentage).toStringAsFixed(2));
//    int closedCases = totalCases - active;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  caseName,
                  style: TextStyles.caseNameTextStyle,
                ),
              ),
              Text(
                todayCases.toString(),
                style: TextStyles.typeCasesTextStyle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),
                      Text(
                        ' $mildCondition %',
                        style: TextStyles.typeConditionPercentageTextStyle,
                      ),
                    ],
                  ),
                ),
                Text(
                  Strings.CONDITION_NAME_1,
                  style: TextStyles.typeConditionTextStyle,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      ),
                      Text(
                        ' $criticalPercentage %',
                        style: TextStyles.typeConditionPercentageTextStyle,
                      ),
                    ],
                  ),
                ),
                Text(
                  Strings.CONDITION_NAME_2,
                  style: TextStyles.typeConditionTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
