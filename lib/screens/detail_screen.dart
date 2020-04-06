import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/utils/strings.dart';
import 'package:fluttercovid19/widgets/card_active.dart';
import 'package:fluttercovid19/widgets/card_closed.dart';
import 'package:fluttercovid19/widgets/card_home.dart';
import 'package:fluttercovid19/constants.dart';
import 'package:fluttercovid19/models/country_detail.dart';
import 'package:fluttercovid19/commons/custom_detail_app_bar.dart';
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
                      Column(
                        children: <Widget>[
                          CustomDetailAppBar(
                              snapshot.data.country,
                              dateFormat,
                              snapshot.data.cases,
                              snapshot.data.countryInfo.flag),
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
                            Strings.CASE_NAME_2,
                            snapshot.data.cases,
                            snapshot.data.active,
                            snapshot.data.todayCases,
                            snapshot.data.critical,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CardClosed(
                          Strings.CASE_NAME_3,
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
            return Center(child: Text(Strings.API_INVALID));
          }
        },
      ),
    );
  }
}
