import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/commons/custom_home_app_bar.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/utils/text_styles.dart';
import 'package:fluttercovid19/widgets/card_cases.dart';
import 'package:fluttercovid19/widgets/card_home.dart';
import 'package:fluttercovid19/screens/detail_screen.dart';
import 'package:fluttercovid19/constants.dart';
import 'package:fluttercovid19/models/all.dart';
import 'package:fluttercovid19/models/countries.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Null> getCountriesData() async {
    final response = await http.get(Strings.URL_COUNTRY);
    if (response.statusCode == 200) {
      final dataCountry = jsonDecode(response.body);
      setState(() {
        for (Map i in dataCountry) {
          countriesList.add(Countries.fromJson(i));
        }
      });
    }
  }

  Future<All> getAllCases() async {
    var response = await http.get(Strings.URL_ALL);
    var decodedJson = json.decode(response.body);
    allCases = All.fromJson(decodedJson);
    return allCases;
  }

  @override
  void initState() {
    super.initState();
    dataAll = getAllCases();
    dataCountry = getCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dataAll,
        builder: (context, AsyncSnapshot<All> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            String dateFormat = updatedDate(snapshot.data.updated);
            return Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: Colors.redAccent),
                      Column(
                        children: <Widget>[
                          CustomHomeAppBar(
                            dateFormat,
                            snapshot.data.cases,
                          ),
                        ],
                      ),
                      //Covid recovery and death
                      Positioned(
                        top: 200,
                        left: 20,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CardWidget(Strings.STATUS_LABEL_NAME_1,
                                  snapshot.data.deaths, Colors.green),
                            ),
                            CardWidget(Strings.STATUS_RECOVERY,
                                snapshot.data.recovered, Colors.red),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //Active vaka sayısı
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CardCases(
                            Strings.CASE_NAME_1, snapshot.data.active),
                      ),
                      //country selection
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                Strings.SELECT_COUNTRY,
                                style: TextStyles.selectCountryTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: DropdownButton(
                                  style: TextStyles.dropdownTextStyle,
                                  elevation: 16,
                                  value: Strings.isSelectedCountry,
                                  items: countriesList
                                      .map((f) => DropdownMenuItem(
                                          value: f.country,
                                          child: Row(
                                            children: <Widget>[
                                              f.countryInfo.flag !=
                                                          "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/unknow.png" ||
                                                      f.country != 'World'
                                                  ? FadeInImage.assetNetwork(
                                                      placeholder:
                                                          'assets/load.gif',
                                                      image: f.countryInfo.flag,
                                                      height: 32,
                                                      width: 64,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FadeInImage(
                                                      placeholder: AssetImage(
                                                          'assets/load.gif'),
                                                      image: AssetImage(
                                                          'assets/worldicon.png'),
                                                      fit: BoxFit.cover,
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                  f.country,
                                                  style: TextStyles
                                                      .dropdownItemTextStyle,
                                                ),
                                              ),
                                            ],
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    Strings.isSelectedCountry = value;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            Strings.isSelectedCountry),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Text(Strings.API_INVALID);
          }
        },
      ),
    );
  }
}
