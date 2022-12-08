import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/utils/base_url.dart';

class DataUnitService {
  Future<List<DataUnitModel>> getDataUnit() async {
    var response = await Dio().get(
      "$baseUrl/data_unit.php",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.data)['data'];
      List<DataUnitModel> products = [];

      for (var item in data) {
        products.add(DataUnitModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
