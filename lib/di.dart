import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:trapper/app/domain/use_case/validate_token.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:trapper/app/presentation/bloc/profile/profile_bloc.dart';
import 'package:trapper/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:trapper/config/dio/dio_tools.dart';
import 'app/data/data_source/local_data.dart';
import 'app/data/data_source/remote_data.dart';
import 'app/data/repository/auth_repository_impl.dart';
import 'app/data/repository/profile_repository_impl.dart';
import 'app/domain/repository/auth_repository.dart';
import 'app/domain/repository/profile_repository.dart';
import 'app/domain/use_case/get_profile.dart';
import 'app/domain/use_case/login.dart';
import 'app/domain/use_case/register.dart';
import 'app/domain/use_case/update_profile.dart';

class DependencyInjection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Bloc
    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        login: sl(),
        register: sl(),
        validateToken: sl(),
      ),
    );
    sl.registerFactory<SettingsBloc>(() => SettingsBloc());
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfile: sl(),
        updateProfile: sl(),
      ),
    );

    // Use case
    sl.registerLazySingleton<Login>(() => Login(authRepository: sl()));
    sl.registerLazySingleton<Register>(() => Register(authRepository: sl()));
    sl.registerLazySingleton<GetProfile>(() => GetProfile(profileRepository: sl()));
    sl.registerLazySingleton<UpdateProfile>(() => UpdateProfile(profileRepository: sl()));
    sl.registerLazySingleton<ValidateToken>(() => ValidateToken(authRepository: sl()));

    // Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localData: sl(),
        remoteData: sl(),
      ),
    );

    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        localData: sl(),
        remoteData: sl(),
      ),
    );

    // Data
    sl.registerLazySingleton<RemoteData>(() => RemoteDataImpl(dio: sl()));
    sl.registerLazySingleton<LocalData>(() => LocalDataImpl(sharedPreferences: sl()));

    // 3th service
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => DioTools.dio);
  }
}
