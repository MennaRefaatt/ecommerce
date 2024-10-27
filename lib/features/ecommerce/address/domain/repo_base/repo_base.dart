import '../../data/model/address_model.dart';
import '../entities/address_param.dart';

abstract class AddressRepoBase {
  Future<AddressModel> getAddress();
  Future<AddressModel> addAddress(AddressParam addressParam);
  Future<AddressModel> updateAddress({required AddressModel address});
  Future<AddressModel> deleteAddress({required String addressId});
}