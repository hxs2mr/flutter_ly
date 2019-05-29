import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hxsly_app/model/home_model.dart';

const HOMR_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

////首页的网络请求
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOMR_URL);
    if (response.statusCode == 200) {
      //修复中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print("获取到的结果"+result.toString());
      return HomeModel.fromJson(result);
    } else {
      throw Exception('请求首页数据异常');
    }
  }
}
