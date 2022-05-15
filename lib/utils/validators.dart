import 'package:get/utils.dart';

class Validators {
  bool email, pass, user;

  bool height = false, weight = false, bodyFat = false;

  Validators({
    this.user = false,
    this.email = false,
    this.pass = false,
  });

  bool emailValidator(value) {
    if (!GetUtils.isEmail(value)) {
      return email = false;
    }
    return email = true;
  }

  bool passValidator(value) {
    if (!GetUtils.isLengthGreaterOrEqual(
        GetUtils.removeAllWhitespace(value), 8)) {
      return pass = false;
    }
    return pass = true;
  }

  bool userValidator(value) {
    if (!GetUtils.isUsername(value)) {
      return user = false;
    }
    return user = true;
  }

  bool isHeight(value) {
    if (value.length < 1 || int.parse(value) < 50 || int.parse(value) > 250) {
      return height = false;
    }
    return height = true;
  }

  bool isBodyFat(value) {
    if (value.length < 1 || int.parse(value) < 0 || int.parse(value) > 100) {
      return bodyFat = false;
    }
    return bodyFat = true;
  }

  bool isWeight(value) {
    if (value.length < 1 || int.parse(value) < 10 || int.parse(value) > 200) {
      return weight = false;
    }
    return weight = true;
  }

  bool hasErroSecondaryData() {
    return !height || !weight || !bodyFat;
  }

  bool isEmpty(String email, String pass, {String? user}) {
    print(email.isEmpty && pass.isEmpty && (user?.isEmpty ?? true));
    return email.isEmpty && pass.isEmpty && (user?.isEmpty ?? true);
  }

  bool hasError({bool withUser = false}) {
    return !email || !pass || !(withUser ? user : true);
  }
}
