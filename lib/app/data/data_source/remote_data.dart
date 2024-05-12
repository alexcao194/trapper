import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../config/dio/dio_tools.dart';
import '../../domain/entity/account.dart';
import '../../domain/entity/profile.dart';
import '../model/account_model.dart';
import '../model/hobby_model.dart';
import '../model/profile_model.dart';


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
  Future<String> sendImage({required Uint8List image, required String roomId});
  Future<void> sendOTP(String email);
  Future<void> resetPassword({required String email, required String otp, required String password});
  Future<void> changePassword({required AccountModel accountModel, required String newPassword});
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
  Future<void> logout() async {
    return;
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
        photos[index] = "${DioTools.baseUrl}/$v";
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

  @override
  Future<String> sendImage({required Uint8List image, required String roomId}) {
    final partFile = MultipartFile.fromBytes(
      image,
      filename: '$roomId.jpg',
    );
    final data = FormData()..files.add(MapEntry('photo_url', partFile));
    return dio.post('/message/image', data: data).then((value) {
      if (value.statusCode == 200) {
        return value.data['photo_url'];
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
  Future<void> resetPassword({required String email, required String otp, required String password}) async {
    var response = await dio.post('/auth/forgot_password', data: {
      'newPassword': password,
      'email': email,
      'otp': otp,
    });
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: jsonEncode(response.data),
      );
    }
  }

  @override
  Future<void> sendOTP(String email) {
    return dio.post('/auth/identify_email', data: {
      'email': email,
    }).then((value) {
      if (value.statusCode != 200) {
        throw DioException(
          requestOptions: value.requestOptions,
          response: value,
          message: jsonEncode(value.data),
        );
      }
    });
  }

  @override
  Future<void> changePassword({required AccountModel accountModel, required String newPassword}) {
    return dio.post('/account/password/change', data: {
      'email': accountModel.email,
      'oldPassword': accountModel.password,
      'newPassword': newPassword,
    }).then((value) {
      if (value.statusCode != 200) {
        throw DioException(
          requestOptions: value.requestOptions,
          response: value,
          message: jsonEncode(value.data),
        );
      }
    });
  }
}
