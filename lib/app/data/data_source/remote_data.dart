import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:trapper/app/data/model/account_model.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/account.dart';

abstract class RemoteData {
  Future<String> login(AccountModel account);
  Future<String> register(AccountModel account, ProfileModel profile);
  Future<void> logout();
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;
  const RemoteDataImpl({required this.dio});

  @override
  Future<String> login(AccountModel account) async {
    var response = await dio.post(
      '/auth/login',
      data: account.toJson()
    );
    if (response.statusCode == 200) {
      return response.data['access_token'];
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<String> register(Account account, ProfileModel profile) async {
    var response = await dio.post(
      '/auth/register',
      data: {
        'email': account.email,
        'password': account.password,
        'full_name': profile.name,
        'gender': profile.gender,
        'date_of_birth': profile.birthDate,
      }
    );

    if (response.statusCode == 200) {
      return response.data['access_token'];
    } else {
      throw Exception(response.data);
    }
  }
}

