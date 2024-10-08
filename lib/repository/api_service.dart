import "package:http/http.dart" as http;
import '../const/string.dart';
import '../models/current_weather_data.dart';
import '../models/hour_weather_data.dart';
// var link = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";


getCurrentWeather(lat, long) async{
  var link = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if(res.statusCode == 200){
    var data = currentWeatherDataFromJson(res.body.toString());
    // print("data is received");
    return data;
  }
}
getHourWeather(lat, long) async{
  var link = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if(res.statusCode == 200){
    var data = hourWeatherDataFromJson(res.body.toString());
    print("hour data is received");
    return data;
  }
}