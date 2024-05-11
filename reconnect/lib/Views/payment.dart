import 'package:dio/dio.dart';

import 'package:reconnect/Views/constant.dart';

class PaymobManager{

  Future<String> getPaymentKey(int amount,String currency,String Name,String email)async{
    try {
      String authanticationToken= await _getAuthanticationToken();

      int orderId= await _getOrderId(
        authanticationToken: authanticationToken, 
        amount: (100*amount).toString(), 
        currency: currency,
      );
      
      String paymentKey= await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100*amount).toString(),
        currency: currency,
        orderId: orderId.toString(), Name:Name,
        email:email,
      );
      return paymentKey;
    } catch (e) {
      print("Exc==========================================");
      print(e.toString());
      throw Exception();
    }
  }

  Future<String>_getAuthanticationToken()async{
    final Response response=await Dio().post(
      "https://accept.paymob.com/api/auth/tokens",
      data: {
        "api_key":Constant.api_key, 
      }
    );
    return response.data["token"];
  }

  Future<int>_getOrderId({
    required String authanticationToken,
    required String amount,
    required String currency,
  })async{
    final Response response=await Dio().post(
      "https://accept.paymob.com/api/ecommerce/orders",
      data: {
        "auth_token":  authanticationToken,
        "amount_cents":amount, //  >>(STRING)<<
        "currency": currency,//Not Req
        "delivery_needed": "false",
        "items": [],
      }
    );
    return response.data["id"];  //INTGER
  }
  
  Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
    required String Name,
    
    required String email,
    
  }) async{
    final Response response=await Dio().post(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      data: {
        //ALL OF THEM ARE REQIERD
        "expiration": 3600,

        "auth_token": authanticationToken,//From First Api
        "order_id":orderId,//From Second Api  >>(STRING)<<
        "integration_id":4564119,//Integration Id Of The Payment Method
        
        "amount_cents": amount, 
        "currency": currency, 
        
        "billing_data": {
          //Have To Be Values
          "first_name": Name, 
          "last_name": "NA", 
          "email": email,
          "phone_number": "+86(8)9135210487",

          //Can Set "NA"
          "apartment": "NA",  
          "floor": "NA", 
          "street": "NA", 
          "building": "NA", 
          "shipping_method": "NA", 
          "postal_code": "NA", 
          "city": "NA", 
          "country": "NA", 
          "state": "NA"
        }, 
      }
    );
    return response.data["token"];
  }

}