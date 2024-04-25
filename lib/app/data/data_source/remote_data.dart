import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trapper/app/data/model/account_model.dart';
import 'package:trapper/app/data/model/hobby_model.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/config/dio/dio_tools.dart';

abstract class RemoteData {
  Future<Map<String, String>> login(AccountModel account);
  Future<Map<String, String>> register(AccountModel account, ProfileModel profile);
  Future<void> logout();
  Future<void> validateToken();
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile, Uint8List? image);
  Future<List<HobbyModel>> getHobbies();
  Future<List<String?>> postPhoto({required Uint8List image, required int index});
  Future<List<Profile>> getFriends();
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;

  const RemoteDataImpl({required this.dio});

  @override
  Future<Map<String, String>> login(AccountModel account) async {
    var response = await dio.post('/auth/login', data: account.toJson());
    switch (response.statusCode) {
      case 200:
        return {"access_token": response.data["access_token"], "refresh_token": response.data["refresh_token"]};
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
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
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    var response = await dio.get('/profile');
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile, Uint8List? image) async {
    if (image != null) {
      final partFile = MultipartFile.fromBytes(
        image,
        filename: 'photo.jpg',
      );
      final data = FormData()..files.add(MapEntry('photo_url', partFile));
      var response = await dio.post(
        '/profile/avatar',
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      if (response.statusCode == 200) {
        profile = ProfileModel.fromEntity(profile.copyWith(photoUrl: "${response.data['photo_url']}"));
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
      }
    }

    var response = await dio.post('/profile', data: profile.toJson());
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<void> validateToken() async {
    var response = await dio.get('/auth/validate');
    if (response.statusCode == 200) {
      return Future.value();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<List<HobbyModel>> getHobbies() {
    var response = dio.get('/hobbies');
    return response.then((value) {
      if (value.statusCode == 200) {
        return (value.data as List).map((e) => HobbyModel.fromJson(e)).toList();
      } else {
        throw DioException(
          requestOptions: value.requestOptions,
          response: value,
          message: jsonEncode(value.data),
        );
      }
    });
  }

  @override
  Future<List<String?>> postPhoto({required Uint8List image, required int index}) async {
    final partFile = MultipartFile.fromBytes(
      image,
      filename: 'photo.jpg',
    );
    final data = FormData()
      ..files.add(MapEntry('photo_url', partFile))
      ..fields.add(MapEntry('index', index.toString()))
    ;
    var response = await dio.post(
      '/profile/photo',
      data: data,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 200) {
      List<String?> photos = List.filled(6, null);
      response.data['photos'].forEach((v) {
        var index = int.parse((v as String).split('/').last.split('-').first);
        photos[index] = "${DioTools.currentBaseUrl}/$v";
      });
      return photos;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<List<Profile>> getFriends() async {
    var response = await dio.get('/profile/friends');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => ProfileModel.fromJson(e)).toList();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }
}
