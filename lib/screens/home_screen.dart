import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final response = await http.get(urlCountry);
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
    var response = await http.get(urlAll);
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
                      //Appbar
                      Positioned(
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      //Covid Cases
                      Positioned(
                        top: 50,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 32, bottom: 16),
                              child: Text(
                                dateFormat.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48),
                              child: Text(
                                'Corona Virus Cases',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 48, top: 16),
                              child: Text(
                                snapshot.data.cases.toString(),
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
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
                              child: CardWidget(
                                  'Deaths', snapshot.data.deaths, Colors.green),
                            ),
                            CardWidget('Recovered', snapshot.data.recovered,
                                Colors.red),
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
                        child: CardCases('Active Cases', snapshot.data.active),
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
                                'Select your country',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey.shade700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: DropdownButton(
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  elevation: 16,
                                  value: isSelectedCountry,
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
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                            ],
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    isSelectedCountry = value;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(isSelectedCountry),
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
            return Text('Invalid Api');
          }
        },
      ),
    );
  }
}
