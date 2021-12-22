// To parse this JSON data, do
//
//     final populationResponse = populationResponseFromJson(jsonString);

import 'dart:convert';

PopulationResponse populationResponseFromJson(String str) => PopulationResponse.fromJson(json.decode(str));

String populationResponseToJson(PopulationResponse data) => json.encode(data.toJson());

class PopulationResponse {
  PopulationResponse({
    this.dataPopulation,
    this.source,
  });

  List<DataPopulation>? dataPopulation;
  List<Source>? source;

  factory PopulationResponse.fromJson(Map<String, dynamic> json) => PopulationResponse(
    dataPopulation: List<DataPopulation>.from(json["data_population"].map((x) => DataPopulation.fromJson(x))),
    source: List<Source>.from(json["source"].map((x) => Source.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data_population": List<dynamic>.from(dataPopulation!.map((x) => x.toJson())),
    "source": List<dynamic>.from(source!.map((x) => x.toJson())),
  };
}

class DataPopulation {
  DataPopulation({
    this.idNation,
    this.nation,
    this.idYear,
    this.year,
    this.population,
    this.slugNation,
  });

  String? idNation;
  String? nation;
  int? idYear;
  String? year;
  int? population;
  String? slugNation;

  factory DataPopulation.fromJson(Map<String, dynamic> json) => DataPopulation(
    idNation: json["ID Nation"],
    nation: json["Nation"],
    idYear: json["ID Year"],
    year: json["Year"],
    population: json["Population"],
    slugNation: json["Slug Nation"],
  );

  Map<String, dynamic> toJson() => {
    "ID Nation": idNation,
    "Nation": nation,
    "ID Year": idYear,
    "Year": year,
    "Population": population,
    "Slug Nation": slugNation,
  };
}

class Source {
  Source({
    this.measures,
    this.annotations,
    this.name,
    this.substitutions,
  });

  List<String>? measures;
  Annotations? annotations;
  String? name;
  List<dynamic>? substitutions;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    measures: List<String>.from(json["measures"].map((x) => x)),
    annotations: Annotations.fromJson(json["annotations"]),
    name: json["name"],
    substitutions: List<dynamic>.from(json["substitutions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "measures": List<dynamic>.from(measures!.map((x) => x)),
    "annotations": annotations!.toJson(),
    "name": name,
    "substitutions": List<dynamic>.from(substitutions!.map((x) => x)),
  };
}

class Annotations {
  Annotations({
    this.sourceName,
    this.sourceDescription,
    this.datasetName,
    this.datasetLink,
    this.tableId,
    this.topic,
    this.subtopic,
  });

  String? sourceName;
  String? sourceDescription;
  String? datasetName;
  String? datasetLink;
  String? tableId;
  String? topic;
  String? subtopic;

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
    sourceName: json["source_name"],
    sourceDescription: json["source_description"],
    datasetName: json["dataset_name"],
    datasetLink: json["dataset_link"],
    tableId: json["table_id"],
    topic: json["topic"],
    subtopic: json["subtopic"],
  );

  Map<String, dynamic> toJson() => {
    "source_name": sourceName,
    "source_description": sourceDescription,
    "dataset_name": datasetName,
    "dataset_link": datasetLink,
    "table_id": tableId,
    "topic": topic,
    "subtopic": subtopic,
  };
}
