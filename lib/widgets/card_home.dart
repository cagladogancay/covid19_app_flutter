import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String statusLabel;
  int status;
  MaterialColor statusColor;

  CardWidget(this.statusLabel, this.status, this.statusColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.transparent,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                statusLabel,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
            Text(
              status.toString(),
              style: TextStyle(
                  fontSize: 24,
                  color: statusColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
