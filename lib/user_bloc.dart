import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/repository.dart';
import 'package:flutter_test_app/user_event.dart';
import 'package:flutter_test_app/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository repo;
  UserBloc({required this.repo}) : super(Initial()) {
    on<FetchUserData>((event, emit) async {
      await fetchUserData(emit);
    });
    add(FetchUserData());
  }

  Future<void> fetchUserData(Emitter<UserState> emit) async {
    try {
      emit(Loading());
      final res = await repo.fetchUsers();
      emit(Loaded(users: res));
    } catch (e) {
      emit(
        Error(
          error: e.toString(),
        ),
      );
    }
  }
}
