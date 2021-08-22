// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    coordinates: (json['coordinates'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };

LocationForecast _$LocationForecastFromJson(Map<String, dynamic> json) {
  return LocationForecast(
    type: json['type'] as String,
    geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationForecastToJson(LocationForecast instance) =>
    <String, dynamic>{
      'type': instance.type,
      'geometry': instance.geometry.toJson(),
      'properties': instance.properties.toJson(),
    };

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  return Properties(
    meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    timeseries: (json['timeseries'] as List<dynamic>)
        .map((e) => Timeseries.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(),
      'timeseries': instance.timeseries.map((e) => e.toJson()).toList(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    updated_at: DateTime.parse(json['updated_at'] as String),
    units: Units.fromJson(json['units'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'updated_at': instance.updated_at.toIso8601String(),
      'units': instance.units.toJson(),
    };

Units _$UnitsFromJson(Map<String, dynamic> json) {
  return Units(
    air_pressure_at_sea_level: json['air_pressure_at_sea_level'] as String?,
    air_temperature: json['air_temperature'] as String?,
    air_temperature_max: json['air_temperature_max'] as String?,
    air_temperature_min: json['air_temperature_min'] as String?,
    cloud_area_fraction: json['cloud_area_fraction'] as String?,
    cloud_area_fraction_high: json['cloud_area_fraction_high'] as String?,
    cloud_area_fraction_low: json['cloud_area_fraction_low'] as String?,
    cloud_area_fraction_medium: json['cloud_area_fraction_medium'] as String?,
    dew_point_temperature: json['dew_point_temperature'] as String?,
    fog_area_fraction: json['fog_area_fraction'] as String?,
    precipitation_amount: json['precipitation_amount'] as String?,
    precipitation_amount_max: json['precipitation_amount_max'] as String?,
    precipitation_amount_min: json['precipitation_amount_min'] as String?,
    probability_of_precipitation:
        json['probability_of_precipitation'] as String?,
    probability_of_thunder: json['probability_of_thunder'] as String?,
    relative_humidity: json['relative_humidity'] as String?,
    ultraviolet_index_clear_sky: json['ultraviolet_index_clear_sky'] as String?,
    wind_from_direction: json['wind_from_direction'] as String?,
    wind_speed: json['wind_speed'] as String?,
    wind_speed_of_gust: json['wind_speed_of_gust'] as String?,
  );
}

Map<String, dynamic> _$UnitsToJson(Units instance) => <String, dynamic>{
      'air_pressure_at_sea_level': instance.air_pressure_at_sea_level,
      'air_temperature': instance.air_temperature,
      'air_temperature_max': instance.air_temperature_max,
      'air_temperature_min': instance.air_temperature_min,
      'cloud_area_fraction': instance.cloud_area_fraction,
      'cloud_area_fraction_high': instance.cloud_area_fraction_high,
      'cloud_area_fraction_low': instance.cloud_area_fraction_low,
      'cloud_area_fraction_medium': instance.cloud_area_fraction_medium,
      'dew_point_temperature': instance.dew_point_temperature,
      'fog_area_fraction': instance.fog_area_fraction,
      'precipitation_amount': instance.precipitation_amount,
      'precipitation_amount_max': instance.precipitation_amount_max,
      'precipitation_amount_min': instance.precipitation_amount_min,
      'probability_of_precipitation': instance.probability_of_precipitation,
      'probability_of_thunder': instance.probability_of_thunder,
      'relative_humidity': instance.relative_humidity,
      'ultraviolet_index_clear_sky': instance.ultraviolet_index_clear_sky,
      'wind_from_direction': instance.wind_from_direction,
      'wind_speed': instance.wind_speed,
      'wind_speed_of_gust': instance.wind_speed_of_gust,
    };

Timeseries _$TimeseriesFromJson(Map<String, dynamic> json) {
  return Timeseries(
    time: DateTime.parse(json['time'] as String),
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TimeseriesToJson(Timeseries instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'data': instance.data.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    instant: DataEntry.fromJson(json['instant'] as Map<String, dynamic>),
    next_12_hours: json['next_12_hours'] == null
        ? null
        : DataEntry.fromJson(json['next_12_hours'] as Map<String, dynamic>),
    next_1_hours: json['next_1_hours'] == null
        ? null
        : DataEntry.fromJson(json['next_1_hours'] as Map<String, dynamic>),
    next_6_hours: json['next_6_hours'] == null
        ? null
        : DataEntry.fromJson(json['next_6_hours'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'instant': instance.instant.toJson(),
      'next_12_hours': instance.next_12_hours?.toJson(),
      'next_1_hours': instance.next_1_hours?.toJson(),
      'next_6_hours': instance.next_6_hours?.toJson(),
    };

DataEntry _$DataEntryFromJson(Map<String, dynamic> json) {
  return DataEntry(
    summary: json['summary'] == null
        ? null
        : Summary.fromJson(json['summary'] as Map<String, dynamic>),
    details: json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataEntryToJson(DataEntry instance) => <String, dynamic>{
      'summary': instance.summary?.toJson(),
      'details': instance.details?.toJson(),
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary(
    symbol_code: json['symbol_code'] as String,
  );
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'symbol_code': instance.symbol_code,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details(
    air_pressure_at_sea_level:
        (json['air_pressure_at_sea_level'] as num?)?.toDouble(),
    air_temperature: (json['air_temperature'] as num?)?.toDouble(),
    air_temperature_max: (json['air_temperature_max'] as num?)?.toDouble(),
    air_temperature_min: (json['air_temperature_min'] as num?)?.toDouble(),
    cloud_area_fraction: (json['cloud_area_fraction'] as num?)?.toDouble(),
    cloud_area_fraction_high:
        (json['cloud_area_fraction_high'] as num?)?.toDouble(),
    cloud_area_fraction_low:
        (json['cloud_area_fraction_low'] as num?)?.toDouble(),
    cloud_area_fraction_medium:
        (json['cloud_area_fraction_medium'] as num?)?.toDouble(),
    dew_point_temperature: (json['dew_point_temperature'] as num?)?.toDouble(),
    fog_area_fraction: (json['fog_area_fraction'] as num?)?.toDouble(),
    precipitation_amount: (json['precipitation_amount'] as num?)?.toDouble(),
    precipitation_amount_max:
        (json['precipitation_amount_max'] as num?)?.toDouble(),
    precipitation_amount_min:
        (json['precipitation_amount_min'] as num?)?.toDouble(),
    probability_of_precipitation:
        (json['probability_of_precipitation'] as num?)?.toDouble(),
    probability_of_thunder:
        (json['probability_of_thunder'] as num?)?.toDouble(),
    relative_humidity: (json['relative_humidity'] as num?)?.toDouble(),
    ultraviolet_index_clear_sky:
        (json['ultraviolet_index_clear_sky'] as num?)?.toDouble(),
    wind_from_direction: (json['wind_from_direction'] as num?)?.toDouble(),
    wind_speed: (json['wind_speed'] as num?)?.toDouble(),
    wind_speed_of_gust: (json['wind_speed_of_gust'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'air_pressure_at_sea_level': instance.air_pressure_at_sea_level,
      'air_temperature': instance.air_temperature,
      'air_temperature_max': instance.air_temperature_max,
      'air_temperature_min': instance.air_temperature_min,
      'cloud_area_fraction': instance.cloud_area_fraction,
      'cloud_area_fraction_high': instance.cloud_area_fraction_high,
      'cloud_area_fraction_low': instance.cloud_area_fraction_low,
      'cloud_area_fraction_medium': instance.cloud_area_fraction_medium,
      'dew_point_temperature': instance.dew_point_temperature,
      'fog_area_fraction': instance.fog_area_fraction,
      'precipitation_amount': instance.precipitation_amount,
      'precipitation_amount_max': instance.precipitation_amount_max,
      'precipitation_amount_min': instance.precipitation_amount_min,
      'probability_of_precipitation': instance.probability_of_precipitation,
      'probability_of_thunder': instance.probability_of_thunder,
      'relative_humidity': instance.relative_humidity,
      'ultraviolet_index_clear_sky': instance.ultraviolet_index_clear_sky,
      'wind_from_direction': instance.wind_from_direction,
      'wind_speed': instance.wind_speed,
      'wind_speed_of_gust': instance.wind_speed_of_gust,
    };
