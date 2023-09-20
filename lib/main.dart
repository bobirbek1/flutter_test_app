import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/model.dart';
import 'package:flutter_test_app/repository.dart';
import 'package:flutter_test_app/user_bloc.dart';
import 'package:flutter_test_app/user_state.dart';

void main(List<String> args) {
  final dio = Dio()
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  runApp(MyApp(dio));
}

class MyApp extends StatefulWidget {
  final Dio dio;
  const MyApp(this.dio, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        repo: Repository(
          client: widget.dio,
        ),
      ),
      child: MaterialApp(
        home: Scaffold(
          appBar: _buildAppBar(),
          body: Center(
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              final isLoading = state is Loading;
              final isError = state is Error;
              final isLoaded = state is Loaded;
              return isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : isError
                      ? Text(
                          "Some error occured: \n${state.error}",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                          ),
                        )
                      : ListView.builder(
                          itemCount: isLoaded ? state.users.length : 0,
                          itemBuilder: (context, index) {
                            final user = (state as Loaded).users[index];
                            return _buildItem(user);
                          },
                        );
            }),
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("Test app"),
    );
  }

  Widget _buildItem(User user) {
    return ListTile(
      title: Text(user.firstName ?? ""),
      subtitle: Text(user.lastName ?? ""),
    );
  }
}
