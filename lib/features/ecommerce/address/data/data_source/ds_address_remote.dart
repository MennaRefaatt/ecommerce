import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/services/network/api_service.dart';
import 'package:ecommerce/features/ecommerce/address/domain/entities/address_param.dart';
import '../../../../../core/services/network/api_constants.dart';
import '../model/address_model.dart';

abstract class DsAddressRemote {
  Future<AddressModel> getAddress();
  Future<AddressModel> addAddress(AddressParam addressParam);
  Future<AddressModel> updateAddress({required AddressModel address});
  Future<AddressModel> deleteAddress({required String addressId});
}

class DsAddressRemoteImpl implements DsAddressRemote {
  @override
  Future<AddressModel> addAddress(AddressParam addressParam) async {
    final response = await ApiService.postData(
      endPoint: EndPoints.address,
      data: addressParam.toJson(),
    );
    try {
      safePrint(response);
      AddressModel addressModel = AddressModel.fromJson(response);
      return addressModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> deleteAddress({required String addressId}) async {
    final response = await ApiService.deleteData(
        endPoint: EndPoints.addressDelete + addressId);
    try {
      AddressModel addressModel = AddressModel.fromJson(response);
      return addressModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> getAddress() async {
    final response = await ApiService.getData(endPoint: EndPoints.address);
    try {
      AddressModel addressModel = AddressModel.fromJson(response);
      return addressModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> updateAddress({required AddressModel address}) async {
    Map<String, dynamic> addressDataMap = {
      for (var item in address.data) item.id.toString(): item.toJson()
    };
    final response = await ApiService.putData(
        endPoint: EndPoints.addressUpdate, data: addressDataMap);
    try {
      AddressModel addressModel = AddressModel.fromJson(response);
      return addressModel;
    } catch (e) {
      rethrow;
    }
  }
}
