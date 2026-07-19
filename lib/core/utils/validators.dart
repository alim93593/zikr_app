abstract class Validator {
  /// Returns null when valid, otherwise an error message.
  String? validate(String? value);
}

class RequiredValidator implements Validator {
  final String message;
  RequiredValidator([this.message = 'This field is required']);

  @override
  String? validate(String? value) => (value == null || value.trim().isEmpty) ? message : null;
}

class EmailValidator implements Validator {
  final String message;
  EmailValidator([this.message = 'Invalid email']);

  final _emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return message;
    return _emailRegex.hasMatch(value.trim()) ? null : message;
  }
}

class MinLengthValidator implements Validator {
  final int min;
  final String message;
  MinLengthValidator(this.min, [String? message]) : message = message ?? 'Minimum length is $min';

  @override
  String? validate(String? value) {
    if (value == null) return message;
    return value.trim().length < min ? message : null;
  }
}

class MaxLengthValidator implements Validator {
  final int max;
  final String message;
  MaxLengthValidator(this.max, [String? message]) : message = message ?? 'Maximum length is $max';

  @override
  String? validate(String? value) {
    if (value == null) return null; // empty allowed
    return value.trim().length > max ? message : null;
  }
}

class CompositeValidator implements Validator {
  final List<Validator> validators;
  CompositeValidator(this.validators);

  @override
  String? validate(String? value) {
    for (final v in validators) {
      final res = v.validate(value);
      if (res != null) return res;
    }
    return null;
  }
}
