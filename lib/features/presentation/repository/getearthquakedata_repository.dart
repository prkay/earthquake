import 'package:earthquake/features/model/earthquake_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class GetEarthQuakDataRepostiory {
  static Future<dynamic> getEarthQuakeData(
      String time, String magnitude) async {
    try {
      Response res = await http.get(Uri(
          path:
              'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$time&minmagnitude=$magnitude'));
      print(res.body);
      if (res.statusCode == 200) {
        return EarthQuakeData.fromJson(json.decode(res.body));
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
