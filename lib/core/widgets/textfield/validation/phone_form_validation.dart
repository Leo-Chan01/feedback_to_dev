import 'package:feedback_to_vfd/core/widgets/textfield/validation/form_validation.dart';

class PhoneFormValidation extends FormValidation {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, enter your phone number';
    }
    return null;
  }
}
