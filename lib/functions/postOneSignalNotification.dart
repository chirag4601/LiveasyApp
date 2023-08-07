import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/functions/BackgroundAndLocation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

postNotification(
    String loadingPointCityPostLoad, String unloadingPointCityPostLoad) async {
  print("post Notification triggered");
  String oneSignalAppId = FlutterConfig.get("oneSignalAppId").toString();
  String oneSignalApiKey = FlutterConfig.get("oneSignalApiKey").toString();
  Map data = {
    "included_segments": ["Subscribed Users"],
    "app_id": oneSignalAppId,
    "contents": {"en": "New load for you!"},
    "headings": {
      "en":
      "$loadingPointCityPostLoad to $unloadingPointCityPostLoad. Book NOW!"
    }
  };
  String body = json.encode(data);
  var jsonData;

  final String oneSignalApiUrl = "https://onesignal.com/api/v1/notifications";

  final response = await http.post(Uri.parse(oneSignalApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic $oneSignalApiKey'
      },
      body: body);
  jsonData = json.decode(response.body);

  //   if (response.statusCode == 201) {
  //     print("LOAD API Response-->$jsonData");
  //     if (jsonData["loadId"] != null) {
  //       String loadId = jsonData["loadId"];
  //       return loadId;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // } catch (e) {
  //   postLoadErrorController.updatePostLoadError(e.toString());
  //   return null;
  // }
}


postBidNotification(
    String loadingPointCityPostLoad, String unloadingPointCityPostLoad, String rate, String unit, String postLoadId) async {
  print("post Bid Notification triggered");
  String oneSignalAppId = FlutterConfig.get("oneSignalAppId").toString();
  String oneSignalApiKey = FlutterConfig.get("oneSignalApiKey").toString();
  Map data = {
    "included_segments": [""],
    "include_external_user_ids" : [postLoadId],
    "app_id": oneSignalAppId,
    "contents": {"en": "New bid applied : Rs$rate - $unit"},
    "headings": {
      "en":
      "$loadingPointCityPostLoad to $unloadingPointCityPostLoad. See NOW!"
    }
  };
  String body = json.encode(data);
  var jsonData;

  final String oneSignalApiUrl = "https://onesignal.com/api/v1/notifications";

  final response = await http.post(Uri.parse(oneSignalApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic $oneSignalApiKey'
      },
      body: body);
  jsonData = json.decode(response.body);

  if (response.statusCode == 201) {
    print("post bid push Notificaion Response-->$jsonData");
    String loadId = jsonData["loadId"];
  } else {
    print("${response.statusCode}-------BAD POST PUSH NOTIFICATION");
  }
}