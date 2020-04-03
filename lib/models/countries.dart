// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) =>
    List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;
  int updated;

  Countries({
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.updated,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        country: json["country"],
        countryInfo: CountryInfo.fromJson(json["countryInfo"]),
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"] == null
            ? null
            : json["casesPerOneMillion"].toDouble(),
        deathsPerOneMillion: json["deathsPerOneMillion"] == null
            ? null
            : json["deathsPerOneMillion"].toDouble(),
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "countryInfo": countryInfo.toJson(),
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion":
            casesPerOneMillion == null ? null : casesPerOneMillion,
        "deathsPerOneMillion":
            deathsPerOneMillion == null ? null : deathsPerOneMillion,
        "updated": updated,
      };
}

class CountryInfo {
  int id;
  String iso2;
  String iso3;
  double lat;
  double long;
  String flag;

  CountryInfo({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        id: json["_id"] == null ? null : json["_id"],
        iso2: json["iso2"] == null ? null : json["iso2"],
        iso3: json["iso3"] == null ? null : json["iso3"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "iso2": iso2 == null ? null : iso2,
        "iso3": iso3 == null ? null : iso3,
        "lat": lat,
        "long": long,
        "flag": flag,
      };
}
