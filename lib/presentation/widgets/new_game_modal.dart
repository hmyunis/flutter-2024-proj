import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_catalogue_app/logic/blocs/userSession/user_session_bloc.dart';
import '../../logic/blocs/games/games_bloc.dart';

class NewGameModal extends StatefulWidget {
  const NewGameModal({super.key});

  @override
  State<NewGameModal> createState() => _NewGameModalState();
}

class _NewGameModalState extends State<NewGameModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    _platformController.dispose();
    _publisherController.dispose();
    _releaseDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: ListView(
        children: [
          const Text(
            'Game Details',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _imageUrlController,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _genreController,
            decoration: const InputDecoration(
              labelText: 'Genre',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _platformController,
            decoration: const InputDecoration(
              labelText: 'Platform',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _publisherController,
            decoration: const InputDecoration(
              labelText: 'Publisher',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _releaseDateController,
            decoration: const InputDecoration(
              labelText: 'Release Date',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.white),
            ),
            maxLines: 3,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 300),
          ElevatedButton.icon(
            onPressed: () {
              context.read<GamesBloc>().add(
                    CreateGameEvent(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      genre: _genreController.text,
                      platform: _platformController.text,
                      publisher: _publisherController.text,
                      releaseDate: _releaseDateController.text,
                      imageUrl: _imageUrlController.text,
                      token: context
                          .read<UserSessionBloc>()
                          .state
                          .token
                          .toString(),
                    ),
                  );
              Future.delayed(const Duration(seconds: 2));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            icon: const Icon(Icons.save),
            label: const Text('Create game',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
