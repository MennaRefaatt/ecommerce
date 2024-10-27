import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/address/data/repo_impl/address_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../data/model/address_model.dart';
import '../../domain/entities/address_param.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addressRepoImpl) : super(AddressInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  List<AddressDataListModel> addressData = [];
  final AddressRepoImpl addressRepoImpl;

  void getAddress() async {
    emit(AddressLoading());
    try {
      final response = await addressRepoImpl.getAddress();
      if (response.status == true) {
        emit(AddressSuccess(addressModel: response));
      } else {
        emit(AddressError(error: response.message.toString()));
      }
    } catch (e) {
      emit(AddressError(error: e.toString()));
    }
  }

  void addAddress() async {
    emit(AddressLoading());
    try {
      final response = await addressRepoImpl.addAddress(AddressParam(
        name: nameController.text,
        city: cityController.text,
        region: regionController.text,
        details: detailsController.text,
        notes: notesController.text,
        latitude: 0.0,
        longitude: 0.0,
      ));
      if (response.status == true) {
        safePrint(response);
        emit(AddressSuccess(addressModel: response));
      } else {
        safePrint(response.message.toString());
        emit(AddressError(error: response.message.toString()));
      }
    } catch (e) {
      safePrint(e.toString());
      emit(AddressError(error: e.toString()));
    }
  }

  deleteAddress({required String addressId}) async {
    emit(AddressLoading());
    try {
      final response =
          await addressRepoImpl.deleteAddress(addressId: addressId);
      if (response.status == true) {
        emit(AddressSuccess(addressModel: response));
      } else {
        emit(AddressError(error: response.message.toString()));
      }
    } catch (e) {
      emit(AddressError(error: e.toString()));
    }
  }

  updateAddress({required AddressModel address}) async {
    emit(AddressLoading());
    try {
      final response = await addressRepoImpl.updateAddress(address: address);
      if (response.status == true) {
        emit(AddressSuccess(addressModel: response));
      } else {
        emit(AddressError(error: response.message.toString()));
      }
    } catch (e) {
      emit(AddressError(error: e.toString()));
    }
  }
}
