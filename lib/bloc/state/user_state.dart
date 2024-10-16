enum UserProcessType { login, logout, create, update, delete }

abstract class UserState {}

class DefaultUserState extends UserState {}

class UserProcessState extends UserState {
  final String message;
  final bool status;
  final UserProcessType type;

  UserProcessState(this.message, this.status, this.type);
}
