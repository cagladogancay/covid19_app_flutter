import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/utils/text_styles.dart';

class CardClosed extends StatelessWidget {
  final String caseName;
  final int totalCases;
  final int active;
  final int death;
  final int recovered;

  CardClosed(
      this.caseName, this.totalCases, this.active, this.death, this.recovered);

  @override
  Widget build(BuildContext context) {
    int closedCases = totalCases - active;
    double deathPercentage =
        double.parse(((death * 100) / closedCases).toStringAsFixed(2));
    double recoveredPercentage =
        double.parse(((recovered * 100) / closedCases).toStringAsFixed(2));

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  caseName,
                  style: TextStyles.caseNameTextStyle,
                ),
              ),
              Text(
                '$closedCases',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        ),
                      ),
                      recovered != 0
                          ? Text(
                              '$recoveredPercentage %',
                              style:
                                  TextStyles.typeConditionPercentageTextStyle,
                            )
                          : Text(
                              Strings.STATUS_NO_RECOVERY,
                              style: TextStyles.noStatusTextStyle,
                            ),
                    ],
                  ),
                ),
                Text(
                  Strings.STATUS_RECOVERY,
                  style: TextStyles.statusTextStyle,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      ),
                      death != 0
                          ? Text(
                              ' $deathPercentage %',
                              style:
                                  TextStyles.typeConditionPercentageTextStyle,
                            )
                          : Text(
                              Strings.STATUS_NO_DEATH,
                              style: TextStyles.noStatusTextStyle,
                            ),
                    ],
                  ),
                ),
                Text(
                  Strings.STATUS_DEATH,
                  style: TextStyles.statusTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
