import '../../model/note_model.dart';

enum NotesProcessType { create, delete, update }

abstract class NotesState {}

class LoadingState extends NotesState {}

class ReadNotesState extends NotesState {
  List<Note> notes;

  ReadNotesState(this.notes);
}

class NoteProcessState extends NotesState {
  final String message;
  final bool status;
  final NotesProcessType type;

  NoteProcessState(this.message, this.status, this.type);
}
