import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:trapper/app/data/model/account_model.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/account.dart';

abstract class RemoteData {
  Future<Map<String, String>> login(AccountModel account);

  Future<Map<String, String>> register(AccountModel account, ProfileModel profile);

  Future<void> logout();

  Future<void> validateToken();

  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile(ProfileModel profile);
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;

  const RemoteDataImpl({required this.dio});

  @override
  Future<Map<String, String>> login(AccountModel account) async {
    var response = await dio.post('/auth/login', data: account.toJson());
    if (response.statusCode == 200) {
      return {"access_token": response.data["access_token"], "refresh_token": response.data["refresh_token"]};
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
  Future<Map<String, String>> register(Account account, ProfileModel profile) async {
    var response = await dio.post('/auth/registry', data: {
      'email': account.email,
      'password': account.password,
      'full_name': profile.name,
      'gender': profile.gender,
      'date_of_birth': profile.birthDate,
    });

    if (response.statusCode == 200) {
      return {"access_token": response.data["access_token"], "refresh_token": response.data["refresh_token"]};
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    var response = await dio.get('/profile');
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    var response = await dio.put('/profile', data: profile.toJson());
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<void> validateToken() async {
    var response = await dio.get('/auth/validate');
    if (response.statusCode == 200) {
      return Future.value();
    } else {
      throw Exception(response.data);
    }
  }
}
