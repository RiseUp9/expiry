class Validators{
  // Crear regExp
  // Email:
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  // Password:
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );


  //username
  static final RegExp _usernameRegExp =  RegExp(
    r'^[a-zA-Z0-9]+$',
  );

  // 2 funciones:
  //isUsername
  static isValidUsername(String username){
    return _usernameRegExp.hasMatch(username);
  }
  // isValidEmail
  static isValidEmail(String email){
    return _emailRegExp.hasMatch(email);
  }

  // isValidPassword
  static isValidPassword(String password){
    return _passwordRegExp.hasMatch(password);
  }
}