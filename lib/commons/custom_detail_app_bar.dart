import 'package:flutter/material.dart';
import 'package:fluttercovid19/screens/home_screen.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/utils/text_styles.dart';

class CustomDetailAppBar extends StatefulWidget {
  String country, dateFormat, flag;
  int cases;
  CustomDetailAppBar(this.country, this.dateFormat, this.cases, this.flag);

  @override
  _CustomDetailAppBarState createState() => _CustomDetailAppBarState();
}

class _CustomDetailAppBarState extends State<CustomDetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(
                context,
                HomeScreen(),
              );
            },
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.country,
                  style: TextStyles.countryNameTextStyle,
                ),
                TextSpan(text: '\n'),
                TextSpan(
                  text: widget.dateFormat,
                  style: TextStyles.appDateTextStyle,
                ),
                TextSpan(text: '\n'),
                TextSpan(text: '\n'),
                TextSpan(
                    text: Strings.APP_TITLE,
                    style: TextStyles.appTitleTextStyle),
                TextSpan(text: '\n'),
                TextSpan(text: '\n'),
                TextSpan(
                  text: widget.cases.toString(),
                  style: TextStyles.casesTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.network(
              widget.flag,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
