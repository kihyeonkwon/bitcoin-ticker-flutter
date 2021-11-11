import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String apiKey = '4181D05C-EBD3-4986-93FD-584E30AB5BA9';
const String endPoint = 'rest.coinapi.io';

const List<String> currenciesList = [
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'JPY',
  'KRW',
  'NZD',
  'USD',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getRate(crypto, currency) async {
    var url = Uri.https(endPoint, '/v1/exchangerate/$crypto/$currency');
    var response = await http.get(url, headers: {"X-CoinAPI-Key": apiKey});
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      print(response.statusCode);
    }
  }
}
