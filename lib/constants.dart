import 'package:fluttercovid19/models/all.dart';
import 'package:fluttercovid19/models/countries.dart';
import 'package:fluttercovid19/models/country_detail.dart';
import 'package:intl/intl.dart';

String updatedDate(int updated) {
  final f = DateFormat('dd-MM-yyyy').add_jm();
  var date = f.format((DateTime.fromMicrosecondsSinceEpoch(
    updated * 1000,
  )));
  return date;
}

//variables
List<Countries> countriesList = [];
Future<Null> dataCountry;
All allCases;
Future<All> dataAll;
Countries allCountries;
Future<CountryDetail> dataDetail;
CountryDetail countryDetail;
