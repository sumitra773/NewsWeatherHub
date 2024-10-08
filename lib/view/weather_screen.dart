import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
// import 'package:velocity_x/velocity_x.dart';

import '../const/images.dart';
import '../const/string.dart';
import '../controller/main_controller.dart';
import '../models/current_weather_data.dart';
import '../models/hour_weather_data.dart';
import '../our_themes.dart';

void main() {
  runApp(const WeatherScreen());
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.DarkTheme,
      themeMode: ThemeMode.system,
      home: const WeatherApp(),
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var them = Theme.of(context);
    var controller = Get.put(MainController());
    return Scaffold(
        backgroundColor: them.scaffoldBackgroundColor,
        appBar: AppBar(
          // title: "$date".text.color(them.primaryColor).make(),
          title: Text("$date",style: TextStyle(color: them.primaryColor)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Obx(
                  () => IconButton(
                  onPressed: () {
                    controller.changeTheme();
                    // Get.changeThemeMode(ThemeMode.dark);
                  },
                  icon: Icon(
                    controller.isDart.value
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: them.iconTheme.color,
                  )),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: them.iconTheme.color,
                ))
          ],
        ),
        body: Obx(() => controller.isLoaded.value == true
            ? Container(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
              future: controller.currentWeatherData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  CurrentWeatherData data = snapshot.data;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.name}",style: TextStyle(
                          fontSize: 20,
                          color: them.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.5,),),
                        // .text
                        // .uppercase
                        // .fontFamily("poppins_bold")
                        // .size(36)
                        // .letterSpacing(3)
                        // .color(them.primaryColor)
                        // .make(),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/weather/${data.weather![0].icon}.png",
                              width: 80,
                              height: 80,
                            ),
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "${data.main!.temp}$degree",
                                      style: TextStyle(
                                        color: them.primaryColor,
                                        fontSize: 40,
                                        fontFamily: "poppins",
                                      )),
                                  TextSpan(
                                      text: " ${data.weather![0].main}",
                                      style: TextStyle(
                                        color: them.primaryColor,
                                        fontSize: 20,
                                        fontFamily: "poppins",
                                      )),
                                ])),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.expand_less,
                                  color: them.primaryColor),
                              label: Text("${data.main!.tempMax}$degree",
                                style: TextStyle(color: them.primaryColor,),),),
                            // .text
                            // .color(them.primaryColor)
                            // .make()),
                            TextButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.expand_more,
                                  color: them.primaryColor),
                              label: Text("${data.main!.tempMin}$degree",
                                style: TextStyle(color: them.primaryColor,),),),
                          ],
                        ),
                        SizedBox(
                          height: 20, // Specify the desired height
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            var iconsList = [clouds, humidity, windspeed];
                            var value = [
                              "${data.clouds!.all}%",
                              "${data.main!.humidity}%",
                              "${data.wind!.speed}km/h"
                            ];
                            return Column(
                              children: [
                                Image.asset(
                                  iconsList[index],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 20, // Specify the desired height
                                ),
                                // value[index].text.gray400.make(),
                                Text(
                                  value[index],
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        SizedBox(
                          height: 20, // Specify the desired height
                        ),
                        const Divider(),
                        SizedBox(
                          height: 20, // Specify the desired height
                        ),
                        FutureBuilder(
                            future: controller.hourWeatherData,
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                HourWeatherData hourData = snapshot.data;
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: hourData.list!.length > 6
                                        ? 6
                                        : hourData.list!.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      var time = DateFormat.jm().format(
                                          DateTime
                                              .fromMillisecondsSinceEpoch(
                                              hourData.list![index]
                                                  .dt!
                                                  .toInt() *
                                                  1000));
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(
                                            right: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Text('time',style: TextStyle(color: Colors.blueGrey),),
                                            Image.asset(
                                                "assets/weather/${hourData.list![index].weather![0].icon}.png",
                                                width: 80),
                                            Text("${hourData.list![index].main!.temp}$degree", style: TextStyle(color: Colors.blueGrey),)
                                            // .text
                                            // .gray600
                                            // .make(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                        SizedBox(
                          height: 20, // Specify the desired height
                        ),
                        const Divider(),
                        SizedBox(
                          height: 20, // Specify the desired height
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Next 7 Days", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: them.primaryColor),),
                            // .text
                            // .semiBold
                            // .size(16)
                            // .color(them.primaryColor)
                            // .make(),
                            TextButton(
                                onPressed: () {},
                                child: Text("View All")),
                          ],
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            var day = DateFormat("EEEE").format(
                                DateTime.now()
                                    .add(Duration(days: index + 1)));
                            return Card(
                              color: them.cardColor,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('day', style: TextStyle(fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor,),),),
                                    // day.text.semiBold
                                    //     .color(them.primaryColor)
                                    //     .make()),
                                    Expanded(
                                      child: TextButton.icon(
                                        onPressed: null,
                                        icon: Image.asset(
                                          "assets/weather/10d.png",
                                          width: 40,
                                        ),
                                        label: Text("26$degree", style: TextStyle(fontSize: 16,color: them.primaryColor),),),
                                      // .text
                                      // .size(16)
                                      // .color(them.primaryColor)
                                      // .make()),
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "37$degree /",
                                              style: TextStyle(
                                                color: them.primaryColor,
                                                fontFamily: "poppins",
                                                fontSize: 16,
                                              )),
                                          TextSpan(
                                              text: " 26$degree",
                                              style: TextStyle(
                                                color: them.iconTheme.color,
                                                fontFamily: "poppins",
                                                fontSize: 16,
                                              ))
                                        ]))
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )
            : Center(
          child: CircularProgressIndicator(),
        )
        )
    );
  }
}
