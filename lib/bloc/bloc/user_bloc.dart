import 'package:db_bloc/bloc/event/user_event.dart';
import 'package:db_bloc/bloc/state/user_state.dart';
import 'package:db_bloc/db/controller/user_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(super.initialState) {
    on<LoginEvent>(login);
    on<LogoutEvent>(logout);
    on<CreateEvent>(createAccount);
    on<UpdateEvent>(updateAccount);
    on<DeleteEvent>(deleteAccount);
  }

  UserController controller = UserController();

  void login(LoginEvent event, Emitter emit) async {
    bool loggedIn =
        await controller.login(email: event.email, password: event.password);
    String message = loggedIn ? 'Success Login' : 'Error Login';
    emit(UserProcessState(message, loggedIn, UserProcessType.login));
  }

  void logout(LogoutEvent event, Emitter emit) async {
    bool loggedOut = await controller.logout();
    String message = loggedOut ? 'Success Logged Out' : 'Error LoggedOut';
    emit(UserProcessState(message, loggedOut, UserProcessType.create));
  }

  void createAccount(CreateEvent event, Emitter emit) async {
    int created = await controller.create(event.model);
    String message = created != 0 ? 'Success Created' : 'Error created';
    emit(UserProcessState(message, created != 0, UserProcessType.create));
  }

  void updateAccount(UpdateEvent event, Emitter emit) async {
    bool updated = await controller.update(event.model);
    String message = updated ? 'Success updated' : 'Error updated';
    emit(UserProcessState(message, updated, UserProcessType.create));
  }

  void deleteAccount(DeleteEvent event, Emitter emit) async {
    bool deleted = await controller.delete(event.id);
    String message = deleted ? 'Success deleted' : 'Error deleted';
    emit(UserProcessState(message, deleted, UserProcessType.create));
  }
}
