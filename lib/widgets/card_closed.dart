import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardClosed extends StatelessWidget {
  String caseName;
  int totalCases;
  int active;
  int death;
  int recovered;

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
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),
              Text(
                '$closedCases',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24),
                            )
                          : Text(
                              'No recovered',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                    ],
                  ),
                ),
                Text(
                  'Recovered',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24),
                            )
                          : Text(
                              'No death',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                    ],
                  ),
                ),
                Text(
                  'Death',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
