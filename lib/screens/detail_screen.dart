import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/widgets/card_active.dart';
import 'package:fluttercovid19/widgets/card_closed.dart';
import 'package:fluttercovid19/widgets/card_home.dart';
import 'package:fluttercovid19/constants.dart';
import 'package:fluttercovid19/models/country_detail.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  String country;

  DetailScreen(this.country);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    String countryName = widget.country.toLowerCase();
    String urlDetail = "https://corona.lmao.ninja/countries/$countryName";
    print(urlDetail);
    Future<CountryDetail> getDetail() async {
      var response = await http.get(urlDetail);
      var decodedJson = json.decode(response.body);
      countryDetail = CountryDetail.fromJson(decodedJson);
      return countryDetail;
    }

    dataDetail = getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dataDetail,
        builder: (context, AsyncSnapshot<CountryDetail> snapshot) {
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
                          title: Text(
                            snapshot.data.country,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                      //Covid Cases
                      Positioned(
                        top: 70,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 160, bottom: 8, top: 8),
                              child: Text(
                                dateFormat.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Corona Virus Cases',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/load.gif',
                                      image: snapshot.data.countryInfo.flag,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 50,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 170, top: 8),
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
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: CardActive(
                            'Today Cases',
                            snapshot.data.cases,
                            snapshot.data.active,
                            snapshot.data.todayCases,
                            snapshot.data.critical,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CardClosed(
                          'Closed Cases',
                          snapshot.data.cases,
                          snapshot.data.active,
                          snapshot.data.deaths,
                          snapshot.data.recovered,
                        ),
                      )
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
