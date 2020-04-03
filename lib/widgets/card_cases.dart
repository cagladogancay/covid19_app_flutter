import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCases extends StatelessWidget {
  int activeCases;
  String caseName;
//  int critical;
//  int totalCase;

  CardCases(this.caseName, this.activeCases);
  @override
  Widget build(BuildContext context) {
    //   double criticalPercentage = (critical * 100) / totalCase;
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
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),
              Text(
                activeCases.toString(),
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
//          Padding(
//            padding: const EdgeInsets.only(bottom: 8),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      Icons.arrow_downward,
//                      color: Colors.green,
//                    ),
//                    //rakam gelicek
//                    Text('%95'),
//                  ],
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(left: 48, top: 8),
//                  child: Text(
//                    'Mild Condition',
//                  ),
//                ),
//                Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      Icons.arrow_upward,
//                      color: Colors.red,
//                    ),
//                    //rakam gelicek
//                    Text(''),
//                  ],
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 8),
//                  child: Text(
//                    'Critical',
//                  ),
//                ),
//              ],
//            ),
//          )
        ],
      ),
    );
  }
}
