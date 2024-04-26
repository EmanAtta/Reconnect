/*
import 'package:dio/dio.dart';
import 'package:reconnect/Views/constant.dart';

class Paymemt {
  Dio dio = Dio();
  Future<String> paywithpaymob(int amount) async {
    try {
      String token = await getToken();
      int id = await getid(token: token, amount: (100 * amount).toString());
      String paymentkey = await getpaymentkey(
          token: token,
          amount: (100 * amount).toString(),
          orderid: id.toString());
      return paymentkey;
    } catch (e) {
      rethrow;
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> getToken() async {
    try {
      Response response = await dio.post(
          ' https://accept.paymob.com/api/auth/tokens',
          data: {"api_key": Constant.api_key});
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getid({required String token, required String amount}) async {
    try {
      Response response = await Dio()
          .post('https://accept.paymob.com/api/ecommerce/orders', data: {
        "auth_token": token,
        "amount_cents": amount,
        "currency": "EGP",
        "items": []
      });
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getpaymentkey(
      {required String token,
      required String amount,
      required String orderid}) async {
    try {
      Response response = await Dio()
          .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
        "auth_token": token,
        "amount_cents": amount,
        
            "currency": "EGP",
        "items": [],
        "billing_data": {
          "apartment": "NA",
          "email": "claudette09@exa.com",
          "floor": "NA",
          "first_name": "Clifford",
          "street": "Hermina Tunnel",
          "building": "90",
          "phone_number": "+86(8)9965214987",
          "shipping_method": "NA",
        }
      });
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }
}
*/