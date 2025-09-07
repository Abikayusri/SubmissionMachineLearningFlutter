// To parse this JSON data, do
//
//     final searchMealResponse = searchMealResponseFromJson(jsonString);

import 'dart:convert';

SearchMealResponse searchMealResponseFromJson(String str) => SearchMealResponse.fromJson(json.decode(str));

String searchMealResponseToJson(SearchMealResponse data) => json.encode(data.toJson());

class SearchMealResponse {
  final List<Map<String, String?>>? meals;

  SearchMealResponse({
    this.meals,
  });

  factory SearchMealResponse.fromJson(Map<String, dynamic> json) => SearchMealResponse(
    meals: json["meals"] == null ? [] : List<Map<String, String?>>.from(json["meals"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
