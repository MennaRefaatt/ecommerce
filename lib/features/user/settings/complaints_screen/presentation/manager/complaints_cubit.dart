import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/complaints_screen/data/repo_impl/complaints_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/forms/user_data_form_validators.dart';
import '../../data/model/complaints_model.dart';
import '../../domain/entity/complaints_param.dart';
part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit(this.complaintsRepo) : super(ComplaintsInitial());
  final ComplaintsRepoBase complaintsRepo;
  UserDataFormValidators userDataFormValidators = UserDataFormValidators();
   TextEditingController messageController = TextEditingController();

  sendComplaints() async {
   emit(ComplaintsLoading());
   final response = await complaintsRepo.sendComplaints(ComplaintsParam(
       name: userDataFormValidators.nameController.text,
       phone: userDataFormValidators.phoneController.text,
       email: userDataFormValidators.emailController.text,
       message: messageController.text
   ));
   if (response.status == true) {
     emit(ComplaintsSuccess(complaintsModel: response));
   } else {
     emit(ComplaintsError(error: response.toString()));
   }
 }
}
