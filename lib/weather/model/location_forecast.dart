// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'location_forecast.g.dart';

typedef Json = Map<String, dynamic>;

//https://developer.yr.no/doc/ForecastJSON/

@JsonSerializable(explicitToJson: true)
class LocationForecast {
  String type;
  Geometry geometry;
  Properties properties;
  LocationForecast(
      {required this.type, required this.geometry, required this.properties});

  factory LocationForecast.fromJson(Json json) =>
      _$LocationForecastFromJson(json);

  Json toJson() => _$LocationForecastToJson(this);

  Forecast? at(DateTime dt) {
    var timeseries = properties.timeseries;
    if (timeseries.length < 1) {
      return null;
    }
    Forecast closest = timeseries[0];
    Duration closestDistance = dt.difference(closest.time).abs();
    for (var ts in timeseries) {
      var distance = ts.time.difference(dt).abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = ts;
      }
    }
    return closest;
  }
}

@JsonSerializable(explicitToJson: true)
class Geometry {
  Geometry({required this.coordinates, required this.type});
  final List<double> coordinates;
  final String type;

  factory Geometry.fromJson(Json json) => _$GeometryFromJson(json);
  Json toJson() => _$GeometryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Properties {
  final Meta meta;
  final List<Timeseries> timeseries;

  Properties({required this.meta, required this.timeseries});

  factory Properties.fromJson(Json json) => _$PropertiesFromJson(json);
  Json toJson() => _$PropertiesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Meta {
  final DateTime updated_at;
  final Units units;

  Meta({required this.updated_at, required this.units});

  factory Meta.fromJson(Json json) => _$MetaFromJson(json);
  Json toJson() => _$MetaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Units {
  String? air_pressure_at_sea_level;
  String? air_temperature;
  String? air_temperature_max;
  String? air_temperature_min;
  String? cloud_area_fraction;
  String? cloud_area_fraction_high;
  String? cloud_area_fraction_low;
  String? cloud_area_fraction_medium;
  String? dew_point_temperature;
  String? fog_area_fraction;
  String? precipitation_amount;
  String? precipitation_amount_max;
  String? precipitation_amount_min;
  String? probability_of_precipitation;
  String? probability_of_thunder;
  String? relative_humidity;
  String? ultraviolet_index_clear_sky;
  String? wind_from_direction;
  String? wind_speed;
  String? wind_speed_of_gust;

  Units(
      {this.air_pressure_at_sea_level,
      this.air_temperature,
      this.air_temperature_max,
      this.air_temperature_min,
      this.cloud_area_fraction,
      this.cloud_area_fraction_high,
      this.cloud_area_fraction_low,
      this.cloud_area_fraction_medium,
      this.dew_point_temperature,
      this.fog_area_fraction,
      this.precipitation_amount,
      this.precipitation_amount_max,
      this.precipitation_amount_min,
      this.probability_of_precipitation,
      this.probability_of_thunder,
      this.relative_humidity,
      this.ultraviolet_index_clear_sky,
      this.wind_from_direction,
      this.wind_speed,
      this.wind_speed_of_gust});

  factory Units.fromJson(Json json) => _$UnitsFromJson(json);
  Json toJson() => _$UnitsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Timeseries {
  DateTime time;
  Data data;

  Timeseries({required this.time, required this.data});

  factory Timeseries.fromJson(Json json) => _$TimeseriesFromJson(json);
  Json toJson() => _$TimeseriesToJson(this);
}

typedef Forecast = Timeseries;

@JsonSerializable(explicitToJson: true)
class Data {
  DataEntry instant;
  DataEntry? next_12_hours;
  DataEntry? next_1_hours;
  DataEntry? next_6_hours;
  Data(
      {required this.instant,
      this.next_12_hours,
      this.next_1_hours,
      this.next_6_hours});
  factory Data.fromJson(Json json) => _$DataFromJson(json);
  Json toJson() => _$DataToJson(this);

  DataEntry get next =>
      next_1_hours ?? next_6_hours ?? next_12_hours ?? instant;
}

@JsonSerializable(explicitToJson: true)
class DataEntry {
  Summary? summary;
  Details? details;

  DataEntry({this.summary, this.details});
  factory DataEntry.fromJson(Json json) => _$DataEntryFromJson(json);
  Json toJson() => _$DataEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Summary {
  String symbol_code;
  Summary({required this.symbol_code});
  factory Summary.fromJson(Json json) => _$SummaryFromJson(json);
  Json toJson() => _$SummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Details {
  double? air_pressure_at_sea_level;
  double? air_temperature;
  double? air_temperature_max;
  double? air_temperature_min;
  double? cloud_area_fraction;
  double? cloud_area_fraction_high;
  double? cloud_area_fraction_low;
  double? cloud_area_fraction_medium;
  double? dew_point_temperature;
  double? fog_area_fraction;
  double? precipitation_amount;
  double? precipitation_amount_max;
  double? precipitation_amount_min;
  double? probability_of_precipitation;
  double? probability_of_thunder;
  double? relative_humidity;
  double? ultraviolet_index_clear_sky;
  double? wind_from_direction;
  double? wind_speed;
  double? wind_speed_of_gust;

  Details(
      {this.air_pressure_at_sea_level,
      this.air_temperature,
      this.air_temperature_max,
      this.air_temperature_min,
      this.cloud_area_fraction,
      this.cloud_area_fraction_high,
      this.cloud_area_fraction_low,
      this.cloud_area_fraction_medium,
      this.dew_point_temperature,
      this.fog_area_fraction,
      this.precipitation_amount,
      this.precipitation_amount_max,
      this.precipitation_amount_min,
      this.probability_of_precipitation,
      this.probability_of_thunder,
      this.relative_humidity,
      this.ultraviolet_index_clear_sky,
      this.wind_from_direction,
      this.wind_speed,
      this.wind_speed_of_gust});
  factory Details.fromJson(Json json) => _$DetailsFromJson(json);
  Json toJson() => _$DetailsToJson(this);
}
