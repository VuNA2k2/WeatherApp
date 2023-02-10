import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:weather_app/data/resources/colors.dart';

toastWarning(String text) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

toastSuccess(String text) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.primaryColor,
    textColor: AppColor.textColor,
    fontSize: 16.0);

const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: "Quicksand",
    fontSize: 20,
    color: Colors.black);
const matchParent = double.infinity;

class EndPoints {
  static const String idBaseUrl = "http://10.20.203.6:8000";
  // static const String idBaseUrl = 'https://tc-be.eztek.net';
  static const String getLocations = '/api/location/get_location/';
  static const String getWeatherByLocationAtDate = '/api/weather/get_weather_by_location_at_date/';
}
