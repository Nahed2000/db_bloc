import 'package:db_bloc/bloc/event/note_event.dart';
import 'package:db_bloc/bloc/state/note_state.dart';
import 'package:db_bloc/db/controller/note_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/note_model.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(super.initialState) {
    on<ReadNotesEvent>(readNotes);
    on<CreateNotesEvent>(createNotes);
    on<UpdateNotesEvent>(updateNotes);
    on<DeleteNotesEvent>(deleteNotes);
  }

  NoteController noteController = NoteController();
  List<Note> notes = [];
  bool isLoading = false;

  void readNotes(ReadNotesEvent event, Emitter emit) async {
    isLoading = true;
    notes = await noteController.read();
    isLoading = false;
    emit(ReadNotesState(notes));
  }

  void createNotes(CreateNotesEvent event, Emitter emit) async {
    int newRowId = await noteController.create(event.object);
    if (newRowId != 0) {
      event.object.id = newRowId;
      notes.add(event.object);
    }
    String message = newRowId != 0 ? 'Successfully Add' : 'Failed Add';
    emit(NoteProcessState(message, newRowId != 0, NotesProcessType.create));
    emit(ReadNotesState(notes));
  }

  void updateNotes(UpdateNotesEvent event, Emitter emit) async {
    bool updated = await noteController.update(event.object);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == event.object.id);
      if (index != -1) {
        notes[index] = event.object;
      }
    }
    String message = updated ? 'Successfully Updated' : 'Failed updated';
    emit(NoteProcessState(message, updated, NotesProcessType.update));
    emit(ReadNotesState(notes));
  }

  void deleteNotes(DeleteNotesEvent event, Emitter emit) async {
    bool deleted = await noteController.delete(event.id);
    if (deleted) {
      notes.removeWhere((element) => element.id == event.id);
    }
    String message = deleted ? 'Successfully Deleted' : 'Failed Delete';
    emit(NoteProcessState(message, deleted, NotesProcessType.delete));
    emit(ReadNotesState(notes));
  }
}
