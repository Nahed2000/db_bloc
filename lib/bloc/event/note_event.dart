abstract class NotesEvent {}

class ReadNotesEvent extends NotesEvent {}

class CreateNotesEvent<T> extends NotesEvent {
  final T object;

  CreateNotesEvent(this.object);
}

class UpdateNotesEvent<T> extends NotesEvent {
  final T object;

  UpdateNotesEvent(this.object);
}

class DeleteNotesEvent extends NotesEvent {
  final int id;

  DeleteNotesEvent(this.id);
}
