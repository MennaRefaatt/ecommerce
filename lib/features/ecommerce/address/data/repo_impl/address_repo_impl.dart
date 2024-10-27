import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/address/data/data_source/ds_address_remote.dart';

import '../../domain/entities/address_param.dart';
import '../../domain/repo_base/repo_base.dart';
import '../model/address_model.dart';

class AddressRepoImpl implements AddressRepoBase {
  final DsAddressRemote dsAddressRemote;

  AddressRepoImpl({required this.dsAddressRemote});

  @override
  Future<AddressModel> addAddress(AddressParam addressParam) async {
    try {
      final response = await dsAddressRemote.addAddress(addressParam);
      safePrint(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> deleteAddress({required String addressId}) async {
    try {
      final response =
          await dsAddressRemote.deleteAddress(addressId: addressId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> getAddress() async {
    try {
      final response = await dsAddressRemote.getAddress();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddressModel> updateAddress({required AddressModel address}) async {
    try {
      final response = await dsAddressRemote.updateAddress(address: address);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
