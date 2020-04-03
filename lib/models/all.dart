// To parse this JSON data, do
//
//     final all = allFromJson(jsonString);

import 'dart:convert';

All allFromJson(String str) => All.fromJson(json.decode(str));

String allToJson(All data) => json.encode(data.toJson());

class All {
  int cases;
  int deaths;
  int recovered;
  int updated;
  int active;

  All({
    this.cases,
    this.deaths,
    this.recovered,
    this.updated,
    this.active,
  });

  factory All.fromJson(Map<String, dynamic> json) => All(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
        updated: json["updated"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "recovered": recovered,
        "updated": updated,
        "active": active,
      };
}
