import 'package:db_bloc/bloc/bloc/note_bloc.dart';
import 'package:db_bloc/bloc/event/note_event.dart';
import 'package:db_bloc/util/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/state/note_state.dart';
import 'note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NotesBloc>(context).add(ReadNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(),
                  )),
              icon: const Icon(Icons.add_to_drive))
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<NotesBloc, NotesState>(
        listenWhen: (previous, current) =>
            current is NoteProcessState &&
            current.type == NotesProcessType.delete,
        listener: (context, state) {
          state as NoteProcessState;
          showSnackBar(
              context: context, message: state.message, error: !state.status);
        },
        buildWhen: (previous, current) =>
            current is LoadingState || current is ReadNotesState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReadNotesState && state.notes.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.all(20),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(
                            note: state.notes[index],
                          ),
                        )),
                    title: Text(state.notes[index].title),
                    subtitle: Text(state.notes[index].details),
                    leading: const Icon(Icons.note_alt_outlined),
                    trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<NotesBloc>(context)
                            .add(DeleteNotesEvent(state.notes[index].id));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          } else {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
