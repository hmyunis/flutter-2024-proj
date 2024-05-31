import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../logic/blocs/user/user_bloc.dart';
import '../../logic/blocs/userSession/user_session_bloc.dart';
import '../../models/user.dart';
import '../../core/avatars.dart';
import '../widgets/avatar_picker_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int avatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _usernameController.text = context.read<UserSessionBloc>().state.username;
    _emailController.text = context.read<UserSessionBloc>().state.email;
    _passwordController.text = "";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _showUpdateConfirmationDialog() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm update'),
          content: const Text(
              'Are you sure you want to overwrite all three account details with the new ones?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.blueGrey[200],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              key: const Key("confirm"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed != null && confirmed) {
      context.read<UserBloc>().add(
            UpdateUser(
                User(
                  id: context.read<UserSessionBloc>().state.id,
                  username: _usernameController.text,
                  email: _emailController.text,
                  joinDate: context.read<UserSessionBloc>().state.joinDate,
                  role: context.read<UserSessionBloc>().state.role,
                ),
                _passwordController.text),
          );
    }
  }

  Future<void> _showDeleteConfirmationDialog() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm termination'),
          content: const Text(
              'Are you sure you want to permanently delete your account?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.red[100],
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              key: const Key("terminated"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed != null && confirmed) {
      context.read<UserBloc>().add(
            DeleteUser(
              User(
                id: context.read<UserSessionBloc>().state.id,
                username: _usernameController.text,
                email: _emailController.text,
                joinDate: context.read<UserSessionBloc>().state.joinDate,
                role: context.read<UserSessionBloc>().state.role,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.blueGrey[900],
            elevation: 10,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(avatars[avatarIndex]),
                          radius: 50,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AvatarPickerDialog(),
                            ).then((value) {
                              setState(() {
                                if (value == null) {
                                  avatarIndex = 0;
                                } else {
                                  avatarIndex = value;
                                }
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context.read<UserSessionBloc>().state.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserError) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red.withOpacity(0.3),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        );
                      }
                      if (state is UserUpdateSuccess) {
                        context.read<UserSessionBloc>().add(
                              UserSessionLogin(
                                User(
                                  id: state.user.id,
                                  username: state.user.username,
                                  email: state.user.email,
                                  joinDate: state.user.joinDate,
                                  role: state.user.role,
                                  token: context
                                      .read<UserSessionBloc>()
                                      .state
                                      .token,
                                ),
                              ),
                            );
                        setState(() {
                          _usernameController.text = state.user.username;
                          _emailController.text = state.user.email;
                          _passwordController.text = "";
                        });
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    'Account updated successfully.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.7),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                      }
                      if (state is UserDeleteSuccess) {
                        context.read<UserSessionBloc>().add(
                              UserSessionLogout(),
                            );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    'Account deleted successfully.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            backgroundColor: Colors.red.withOpacity(0.5),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                        context.go('/');
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      }
                      if (state is UserUpdateSuccess) {}

                      return Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Join date: ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Text(
                                context.read<UserSessionBloc>().state.joinDate,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            key: const Key("username_field"),
                            controller: _usernameController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.person),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            key: const Key("email"),
                            controller: _emailController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.email),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            key: const Key("newPassword"),
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(Icons.lock_outline),
                              prefixIconColor: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                key: const Key("terminate"),
                                onPressed: _showDeleteConfirmationDialog,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red[700]),
                                ),
                                label: const Text('Terminate'),
                                icon: const Icon(Icons.dangerous_rounded),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                key: const Key("update"),
                                onPressed: _showUpdateConfirmationDialog,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue[700]),
                                ),
                                label: const Text('Update'),
                                icon: const Icon(Icons.edit_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          context.read<UserSessionBloc>().state.role == "owner"
              ? ElevatedButton.icon(
                  onPressed: () {
                    context.push('/rolemgt');
                    context.read<UserBloc>().add(FetchUsers());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                  ),
                  label: const Text(
                    'Role configuration setting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
