import 'package:get/utils.dart';
import 'package:play_workout/models/enum/return_type.dart';

class Validators {
  List<ReturnType> returnType = [ReturnType.allError];

  void _changeStatus(ReturnType returnTypeParameter, [bool isClear = false]) {
    if (isClear && returnType.first == ReturnType.allError) {
      returnType = [ReturnType.allClear];
    }
    if ((returnType.contains(returnTypeParameter) ||
            returnType.first == ReturnType.allClear) &&
        isClear) {
      returnType.removeWhere(
          (e) => e == returnTypeParameter || e == ReturnType.allClear);
      if (returnType.isEmpty) {
        returnType = [ReturnType.allClear];
      }
      return;
    }
    if (!returnType.contains(returnTypeParameter) && !isClear) {
      if (returnType.first == ReturnType.allError ||
          returnType.first == ReturnType.allClear) {
        returnType.removeAt(0);
      }
      returnType.add(returnTypeParameter);
    }
  }

  ReturnType get hasError => returnType.first;

  void resetValidator() => returnType = [ReturnType.allError];

  void resetToAllClear() => returnType = [ReturnType.allClear];

  bool emailValidator(value) {
    if (!GetUtils.isEmail(value)) {
      _changeStatus(ReturnType.emailError);
      return false;
    }
    _changeStatus(ReturnType.emailError, true);
    return true;
  }

  bool passValidator(value) {
    if (!GetUtils.isLengthGreaterOrEqual(
        GetUtils.removeAllWhitespace(value), 8)) {
      _changeStatus(ReturnType.passwordError);
      return false;
    }
    _changeStatus(ReturnType.passwordError, true);
    return true;
  }

  bool userValidator(value) {
    if (!GetUtils.isUsername(value)) {
      _changeStatus(ReturnType.userError);
      return false;
    }
    _changeStatus(ReturnType.userError, true);
    return true;
  }

  bool isHeight(value) {
    if (value.length < 1 || int.parse(value) < 50 || int.parse(value) > 250) {
      _changeStatus(ReturnType.heightError);
      return false;
    }
    _changeStatus(ReturnType.heightError, true);
    return true;
  }

  bool isBodyFat(value) {
    if (value.length < 1 || int.parse(value) < 0 || int.parse(value) > 100) {
      _changeStatus(ReturnType.bodyFatError);
      return false;
    }
    _changeStatus(ReturnType.bodyFatError, true);
    return true;
  }

  bool isWeight(value) {
    if (value.length < 1 || int.parse(value) < 10 || int.parse(value) > 200) {
      _changeStatus(ReturnType.weightError);
      return false;
    }
    _changeStatus(ReturnType.weightError, true);
    return true;
  }

  bool isAlphabetic(value) {
    if (!RegExp(
      r"^[\p{L} ,.'-]*$",
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    ).hasMatch(value)) {
      _changeStatus(ReturnType.notAlphabeticError);
      return false;
    }
    _changeStatus(ReturnType.notAlphabeticError, true);
    return true;
  }

  bool isNumber(value) {
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      _changeStatus(ReturnType.notNumberError);
      return false;
    }
    _changeStatus(ReturnType.notNumberError, true);
    return true;
  }

  bool isPhone(value) {
    if (!GetUtils.isPhoneNumber(value)) {
      _changeStatus(ReturnType.phoneError);
      return false;
    }
    _changeStatus(ReturnType.phoneError, true);
    return true;
  }

  bool isCPF(value) {
    if (!GetUtils.isCpf(value)) {
      _changeStatus(ReturnType.cpfError);
      return false;
    }
    _changeStatus(ReturnType.cpfError, true);
    return true;
  }

  bool isCEP(value) {
    if (value.length != 8) {
      _changeStatus(ReturnType.cepError);
      return false;
    }
    _changeStatus(ReturnType.cepError, true);
    return true;
  }

  bool simpleValidation(value) {
    if (value.length <= 0) {
      _changeStatus(ReturnType.lengthError);
      return false;
    }
    _changeStatus(ReturnType.lengthError, true);
    return true;
  }

  bool isEmpty(String email, String pass, {String? user}) {
    return email.isEmpty && pass.isEmpty && (user?.isEmpty ?? true);
  }
}
