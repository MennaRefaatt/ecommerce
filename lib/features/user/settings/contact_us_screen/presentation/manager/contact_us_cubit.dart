import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/user/settings/contact_us_screen/domain/repo_base/repo_base.dart';
import 'package:meta/meta.dart';

import '../../data/model/contact_us_model.dart';
part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.contactUsRepoBase) : super(ContactUsInitial());
final ContactUsRepoBase contactUsRepoBase;

   getContactUs() async{
    emit(ContactUsLoading());
    final response = await contactUsRepoBase.getContactUs();
    try {
      if(response.status == true){
        emit(ContactUsSuccess(contactUsModel: response));
      }else{
        emit(ContactUsError(error:response.status.toString()));
      }
    } catch (e) {
      emit(ContactUsError(error: e.toString()));
    }
  }
}
