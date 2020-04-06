import 'package:fluttercovid19/models/all.dart';
import 'package:fluttercovid19/models/countries.dart';
import 'package:fluttercovid19/models/country_detail.dart';
import 'package:intl/intl.dart';

String updatedDate(int updated) {
  var date = (DateTime.fromMicrosecondsSinceEpoch(
    updated * 1000,
  ));
  String dateFormat = DateFormat.yMd().add_jm().format(date);
  return dateFormat;
}

//variables
List<Countries> countriesList = [];
Future<Null> dataCountry;
All allCases;
Future<All> dataAll;
Countries allCountries;
Future<CountryDetail> dataDetail;
CountryDetail countryDetail;
