import 'package:db_bloc/bloc/event/note_event.dart';
import 'package:db_bloc/util/helpers.dart';
import 'package:db_bloc/widget/custom_elevated_button.dart';
import 'package:db_bloc/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/note_bloc.dart';
import '../../bloc/state/note_state.dart';
import '../../model/note_model.dart';
import '../../storge/pref_controller.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key, this.note});

  Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  late TextEditingController titleController;
  late TextEditingController detailsController;

  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController(text: widget.note?.title);
    detailsController = TextEditingController(text: widget.note?.details);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        title: const Text('Add Note'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listenWhen: (previous, current) =>
            current is NoteProcessState &&
            (current.type == NotesProcessType.create ||
                current.type == NotesProcessType.update),
        listener: (context, state) {
          state as NoteProcessState;
          showSnackBar(
              context: context, message: state.message, error: !state.status);
          state.type == NotesProcessType.create
              ? Navigator.pop(context)
              : clear();
          // TODO: implement listener
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.all(20),
          children: [
            CustomTextField(
              controller: titleController,
              hintText: 'Title',
              icon: Icons.title,
              helperText: null,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: detailsController,
              hintText: 'Details',
              icon: Icons.details,
              helperText: null,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(onPress: () => performSave(), title: 'Save')
          ],
        ),
      ),
    );
  }

  void performSave() {
    if (checkData()) {
      save();
    }
  }

  bool checkData() {
    if (titleController.text.isNotEmpty && detailsController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter Your Data', error: true);
    return false;
  }

  void save() {
    isCreate
        ? BlocProvider.of<NotesBloc>(context).add(CreateNotesEvent(note))
        : BlocProvider.of<NotesBloc>(context).add(UpdateNotesEvent(note));
  }

  bool get isCreate => widget.note == null;

  Note get note {
    Note note = Note();
    if (!isCreate) {
      note.id = widget.note!.id;
    }
    note.title = titleController.text;
    note.details = detailsController.text;
    note.userId =
        SharedPrefController().getValueKey<int>(key: PrefKey.id.toString())!;

    return note;
  }

  void clear() {
    titleController.text = '';
    detailsController.text = '';
  }
}
