
import 'package:ecommerce/core/helpers/shared_pref_keys.dart';
import 'package:ecommerce/features/ecommerce/payment/constants/payment_constants.dart';
import 'package:flutter/material.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'core/components/app_entry_point.dart';
import 'core/di/di.dart';
import 'core/helpers/safe_print.dart';
import 'core/helpers/secure_storage/secure_storage.dart';
import 'core/helpers/shared_pref.dart';
import 'core/services/navigation/app_endpoints.dart';
import 'core/services/network/api_service.dart';

Future<void> main() async {
  await PaymobPayment.instance.initialize(
    apiKey: PaymentConstants.apiKey,
    integrationID: PaymentConstants.integrationId,
    iFrameID: PaymentConstants.iFrameId,
  );
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.init();
  await init();
  await SharedPref.init();
  safePrint(SharedPref.getString(key: MySharedKeys.userId));
  SecureStorageService();


  runApp(
    const AppEntryPoint(
      initialRoute: AppEndpoints.splash,
    ),
  );
}
