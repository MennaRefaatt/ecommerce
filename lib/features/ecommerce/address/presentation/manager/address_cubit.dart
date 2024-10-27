import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/features/ecommerce/address/data/repo_impl/address_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../maps/presentation/manager/location_cubit.dart';
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

  void addAddress(double latitude, double longitude) async {
    emit(AddressLoading());
    try {
      final response = await addressRepoImpl.addAddress(AddressParam(
        name: nameController.text,
        city: cityController.text,
        region: regionController.text,
        details: detailsController.text,
        notes: notesController.text,
        latitude: latitude,
        longitude: longitude,
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
        getAddress();
        safePrint(response.toString());
      } else {
        emit(AddressError(error: response.message.toString()));
        safePrint(response.message.toString());
      }
    } catch (e) {
      safePrint(e.toString());
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
  void addAddressWithSelectedLocation(LocationCubit locationCubit) {
    locationCubit.stream.listen((locationState) {
      if (locationState is LocationLoaded) {
       addAddress(locationState.position.latitude, locationState.position.longitude);
      } else if (locationState is LocationMarkerSet) {
       addAddress(locationState.location.latitude, locationState.location.longitude);
      } else if (locationState is LocationError) {
        safePrint(locationState.message);
      }
    });
    locationCubit.fetchUserLocation();
  }


}
