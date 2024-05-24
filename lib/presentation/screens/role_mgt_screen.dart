import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/user/user_bloc.dart';
import '../widgets/role_mgt_pannel.dart';

class RoleMgtScreen extends StatelessWidget {
  const RoleMgtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[700],
        appBar: AppBar(
          title: const Text('Role Management'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        body: BlocConsumer<UserBloc, UserState>(
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
            if (state is PromotionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.keyboard_double_arrow_up,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          'You made ${state.username} an admin.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
            if (state is DemotionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.keyboard_double_arrow_down,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          'You demoted ${state.username}.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ),
              );
            }
            if (state is UsersLoaded) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Accounts",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoleMgtPannel(users: state.users),
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.grey.withOpacity(0.5),
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Error, please reload the page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<UserBloc>().add(FetchUsers());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reload"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue[700],
                      ),
                      shape: const MaterialStatePropertyAll(StadiumBorder()),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
