import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/field_validation.dart';

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  ValidationError validate(Map input) => input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
}
