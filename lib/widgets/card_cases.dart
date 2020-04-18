import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/utils/text_styles.dart';

class CardCases extends StatelessWidget {
  final int activeCases;
  final String caseName;

  CardCases(this.caseName, this.activeCases);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
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
                activeCases.toString(),
                style: TextStyles.typeCasesTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
