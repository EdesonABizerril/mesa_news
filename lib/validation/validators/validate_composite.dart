import 'package:meta/meta.dart';

import '../../presentation/protocols/validation.dart';
import '../protocols/field_validation.dart';
import 'validation_builder.dart';

class ValidationComposite implements Validation {
  List<FieldValidation> _listFieldValidations = [];

  @override
  ValidationError validate({@required String field, @required Map input}) {
    _listFieldValidations = _makeListFieldsValidations();

    return _validateProcess(field, input);
  }

  List<FieldValidation> _makeListFieldsValidations() => [
        ...ValidationBuilder.field('name').required().min(2).build(),
        ...ValidationBuilder.field('email').required().email().build(),
        ...ValidationBuilder.field('password').required().min(6).build(),
        ...ValidationBuilder.field('passwordConfirmation').required().min(6).build(),
      ];

  ValidationError _validateProcess(String field, Map input) {
    ValidationError error;
    for (final validation in _listFieldValidations.where((value) => value.field == field)) {
      error = validation.validate(input);
      if (error != null) {
        return error;
      }
    }
    return error;
  }
}
