

import 'dart:convert';

HourWeatherData hourWeatherDataFromJson(String str) => HourWeatherData.fromJson(json.decode(str));

class HourWeatherData {
  String? cod;
  int? message;
  int? cnt;
  List<ListElement>? list;
  City? city;

  HourWeatherData({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory HourWeatherData.fromJson(Map<String, dynamic> json) => HourWeatherData(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    city: City.fromJson(json["city"]),
  );

}

class City {
  int? id;
  String? name;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
//   "coord": coord.toJson(),
//   "country": country,
//   "population": population,
//   "timezone": timezone,
//   "sunrise": sunrise,
//   "sunset": sunset,
// };
}

// class Coord {
//   double lat;
//   double lon;
//
//   Coord({
//     this.lat,
//     this.lon,
//   });
//
//   factory Coord.fromJson(Map<String, dynamic> json) => Coord(
//     lat: json["lat"].toDouble(),
//     lon: json["lon"].toDouble(),
//   );

//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lon": lon,
//   };
// }

class ListElement {
  int? dt;
  MainClass? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  DateTime? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: MainClass.fromJson(json["main"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: Clouds.fromJson(json["clouds"]),
    wind: Wind.fromJson(json["wind"]),
    dtTxt: DateTime.parse(json["dt_txt"]),
  );

// Map<String, dynamic> toJson() => {
//   "dt": dt,
//   "main": main.toJson(),
//   "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
//   "clouds": clouds.toJson(),
//   "wind": wind.toJson(),
//   "visibility": visibility,
//   "pop": pop,
//   "sys": sys.toJson(),
//   "dt_txt": dtTxt.toIso8601String(),
//   "rain": rain.toJson(),
// };
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainClass {
  int? temp;
  int? tempMin;
  int? tempMax;
  int? humidity;
  MainClass({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"].toInt(),
    tempMin: json["temp_min"].toInt(),
    tempMax: json["temp_max"].toInt(),
    humidity: json["humidity"],
  );

// Map<String, dynamic> toJson() => {
//   "temp": temp,
//   "feels_like": feelsLike,
//   "temp_min": tempMin,
//   "temp_max": tempMax,
//   "pressure": pressure,
//   "sea_level": seaLevel,
//   "grnd_level": grndLevel,
//   "humidity": humidity,
//   "temp_kf": tempKf,
// };
}

class Weather {
  int? id;
  String? icon;

  Weather({
    this.id,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    icon: json["icon"],
  );

}

// enum Description {
//   BROKEN_CLOUDS,
//   CLEAR_SKY,
//   FEW_CLOUDS,
//   LIGHT_RAIN,
//   OVERCAST_CLOUDS,
//   SCATTERED_CLOUDS
// }
//
// final descriptionValues = EnumValues({
//   "broken clouds": Description.BROKEN_CLOUDS,
//   "clear sky": Description.CLEAR_SKY,
//   "few clouds": Description.FEW_CLOUDS,
//   "light rain": Description.LIGHT_RAIN,
//   "overcast clouds": Description.OVERCAST_CLOUDS,
//   "scattered clouds": Description.SCATTERED_CLOUDS
// });
//
// enum MainEnum {
//   CLEAR,
//   CLOUDS,
//   RAIN
// }


class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toDouble(),
    deg: json["deg"],
    gust: json["gust"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}
