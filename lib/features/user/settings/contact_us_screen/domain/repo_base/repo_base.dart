import '../../data/model/contact_us_model.dart';

abstract class ContactUsRepoBase {
  Future <ContactUsModel> getContactUs();
}