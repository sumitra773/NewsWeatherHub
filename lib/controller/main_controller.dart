import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../repository/api_service.dart';

class MainController extends GetxController{
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    hourWeatherData = getHourWeather(latitude.value, longitude.value);
    super.onInit();
  }
  var isDart = false.obs;
  var currentWeatherData;
  var hourWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoaded = false.obs;
  changeTheme(){
    isDart.value = !isDart.value;
    Get.changeThemeMode(isDart.value ? ThemeMode.dark : ThemeMode.light);

  }
  getUserLocation() async {
    var isLocationEnabled;
    var userPermission;
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled){
      return Future.error("Location is not enabled");
    }
    userPermission = await Geolocator.checkPermission();
    if(userPermission == LocationPermission.deniedForever){
      return Future.error("Permission is Denied foever");
    }
    else if(userPermission == LocationPermission.denied){
      userPermission = await Geolocator.requestPermission();
      if(userPermission == LocationPermission.denied){
        return Future.error("Permission is Denied");
      }

    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isLoaded.value = true;
    });
  }
}