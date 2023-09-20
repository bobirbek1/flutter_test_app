import 'package:dio/dio.dart';
import 'package:flutter_test_app/model.dart';

class Repository {
  final Dio client;

  Repository({required this.client});

  Future<List<User>> fetchUsers() async {
    final res = await client.get(
      "https://crudcrud.com/api/2e24896c553244e0937c20669cf718fc/users",
    );
    return res.data.map<User>((e) => User.fromJson(e)).toList();
  }
}
