class AuthException {
  static void validateRegisterForm(String name, String surname, String email, String password, String rePassword,String birthDate){
    if(name == "")
      throw("Your name is missing");
    if(surname == "")
      throw("Your surname is missing");
    if(email == "")
      throw("Your email is missing");
    if(password == "")
      throw("Your password is missing");
    if(rePassword == "")
      throw("Your password confirmation is missing");
    if(birthDate == "")  
      throw("is missing");
    if(password != rePassword)
      throw("Your passwords do not match");
    try {
      DateTime.parse(birthDate);
    } catch (e) {
      throw("Your birthdate must be a date");
    }
  }
}