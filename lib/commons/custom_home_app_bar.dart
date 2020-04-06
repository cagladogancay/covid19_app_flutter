import 'package:flutter/material.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/utils/text_styles.dart';

class CustomHomeAppBar extends StatefulWidget {
  String dateFormat;
  CustomHomeAppBar(this.dateFormat);

  @override
  _CustomHomeAppBarState createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.dateFormat,
                    style: TextStyles.appDateTextStyle),
                TextSpan(text: '\n'),
                TextSpan(
                    text: Strings.APP_TITLE,
                    style: TextStyles.appTitleTextStyle),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
