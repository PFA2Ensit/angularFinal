class ValidatorService {
  static String fullNameValidate(String fullName) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (fullName.length == 0) {
      return 'Please enter full name';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid full name';
    }
    return null;
  }

  static String positionValidate(String position) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (position.length == 0) {
      return 'Please enter position';
    } else if (!regExp.hasMatch(position)) {
      return 'Please enter valid position';
    }
    return null;
  }
}
