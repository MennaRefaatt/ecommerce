import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/helpers/secure_storage/secure_storage.dart';
import 'package:ecommerce/core/services/navigation/app_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/helpers/secure_storage/secure_keys.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      String? token = await SecureStorageService.readData(SecureKeys.token);
      safePrint("=========$token");
      if(token != null && token.isNotEmpty){
        safePrint("logged in");
        Modular.to.navigate(AppEndpoints.homeScreen);
      }else{
        safePrint("logged out");
        Modular.to.navigate(AppEndpoints.login);

      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
