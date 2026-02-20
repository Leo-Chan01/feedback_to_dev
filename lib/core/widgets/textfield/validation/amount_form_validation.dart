import 'package:feedback_to_vfd/core/widgets/textfield/validation/form_validation.dart';

class AmountFormValidation extends FormValidation {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, enter an amount';
    } else if ((double.tryParse(value) ?? 0) <= 0) {
      return 'Amount must be greater than 0';
    }
    return null;
  }
}
