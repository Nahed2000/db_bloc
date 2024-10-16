abstract class UserEvent {}

class LoginEvent<T> extends UserEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class CreateEvent<T> extends UserEvent {
  final T model;

  CreateEvent(this.model);
}

class LogoutEvent extends UserEvent {}

class UpdateEvent<T> extends UserEvent {
  final T model;

  UpdateEvent(this.model);
}

class DeleteEvent extends UserEvent {
  final int id;

  DeleteEvent(this.id);
}
