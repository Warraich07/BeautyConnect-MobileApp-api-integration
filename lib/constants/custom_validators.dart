import 'package:flutter/cupertino.dart';

import '../localization/languages/languages.dart';

class CustomValidator {
  static String? email(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.emailIsRequired;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return Languages.of(context)!.pleaseEnterTheValidEmail;
    }
    return null;
  }

  static String? password(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.passwordIsRequired;
    } else if (value.length < 8) {
      return Languages.of(context)!.passwordMustBeEightCharacters;
    }
    return null;
  }

  static String? oldPassword(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.oldPasswordIsRequired;
    } else if (value.length < 8) {
      return Languages.of(context)!.passwordMustBeEightCharacters;
    }
    return null;
  }

  static String? newPassword(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.newPasswordIsRequired;
    } else if (value.length < 8) {
      return Languages.of(context)!.passwordMustBeEightCharacters;
    }
    return null;
  }

  static String? loginPassword(String? value) {
    if (value!.isEmpty) {
      return ' Password is required';
    }

    return null;
  }

  static String? confirmPassword(String? value, String oldPassword,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.confirmPasswordIsRequired;
    } else if (value.length < 8) {
      return Languages.of(context)!.passwordMustBeEightCharacters;
    } else if (value != oldPassword) {
      return Languages.of(context)!.confirmPasswordIsNotMatched;
    }
    return null;
  }

  static String? isEmpty(String? value) {
    if (value!.isEmpty) {
      return ' Field cannot not be empty';
    }
    return null;
  }

  static String? isEmptyTitle(String? value) {
    if (value!.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  static String? isEmptyUserName(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.userNameIsRequired;
    }
    return null;
  }

  static String? number(String? value,BuildContext context) {
    if (value!.isEmpty) {
      return Languages.of(context)!.phoneNumberIsRequired;
    } else if (value.length < 6) {
      return Languages.of(context)!.phoneNumberShouldNotBeLessThanSix;
    }
    return null;
  }

  static String? lessThen2(String? value) {
    return (value!.length < 2) ? ' Enter more then 1 characters' : null;
  }

  static String? lessThen3(String? value) {
    return (value!.length < 3) ? ' Enter more then 2 characters' : null;
  }

  static String? lessThen4(String? value) {
    return (value!.length < 4) ? ' Enter more then 3 characters' : null;
  }

  static String? lessThen5(String? value) {
    return (value!.length < 5) ? ' Enter more then 4 characters' : null;
  }

  static String? greaterThen(String? input, double compareWith) {
    return (double.parse(input ?? '0') < compareWith)
        ? ' New input must be greater'
        : null;
  }

  static String? returnNull(String? value) => null;
}
