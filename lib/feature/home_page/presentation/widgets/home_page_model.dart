class HomeModelState {
  final String _firstName, _lastName, _email;

  HomeModelState(this._firstName, this._lastName, this._email);

  String getFirstName() {
    return _firstName;
  }

  String getLastName() {
    return _lastName;
  }

  String getEmail() {
    return _email;
  }
}
