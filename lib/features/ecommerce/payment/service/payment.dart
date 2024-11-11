import 'package:dio/dio.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';

import '../../../../core/helpers/shared_pref.dart';
import '../../../../core/helpers/shared_pref_keys.dart';
import '../constants/payment_constants.dart';

class PaymobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      String authenticationToken = await _getAuthenticationToken();

      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );

      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      return paymentKey;
    } catch (e) {
      safePrint("Exception: $e");
      throw Exception();
    }
  }

  Future<String> _getAuthenticationToken() async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/auth/tokens",
      data: {"api_key": PaymentConstants.apiKey},
    );
    return response.data["token"];
  }

  Future<int> _getOrderId({
    required String authenticationToken,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/ecommerce/orders",
      data: {
        "auth_token": authenticationToken,
        "amount_cents": amount,
        "currency": currency,
        "delivery_needed": "false",
        "items": [],
      },
    );
    return response.data["id"];
  }

  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      data: {
        "expiration": 3600,
        "auth_token": authenticationToken,
        "order_id": orderId,
        "integration_id": PaymentConstants.integrationId,
        "amount_cents": amount,
        "currency": currency,
        "billing_data": {
          "first_name": SharedPref.getString(key: MySharedKeys.userName),
          "last_name": "NA",
          "email": SharedPref.getString(key: MySharedKeys.email),
          "phone_number": SharedPref.getString(key: MySharedKeys.phone),
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": SharedPref.getString(key: MySharedKeys.city),
          "country": "NA",
          "state": "NA"
        },
      },
    );
    return response.data["token"];
  }
}