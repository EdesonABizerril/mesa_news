import 'package:meta/meta.dart';

import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/field_validation.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  ValidationError validate(Map input) =>
      input[field] != null && input[field].length >= size ? null : ValidationError.invalidField;
}
