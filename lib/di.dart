import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/app/data/data_source/socket_data.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/data/model/settings_snapshot_model.dart';
import 'package:trapper/app/domain/repository/socket_repository.dart';
import 'package:trapper/app/domain/use_case/fetch_hobbies.dart';
import 'package:trapper/app/domain/use_case/fetch_rooms_info.dart';
import 'package:trapper/app/domain/use_case/validate_token.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:trapper/app/presentation/bloc/profile/profile_bloc.dart';
import 'package:trapper/app/presentation/bloc/rooms/rooms_bloc.dart';
import 'package:trapper/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:trapper/config/dio/dio_tools.dart';
import 'package:trapper/config/socket/app_socket.dart';
import 'app/data/data_source/local_data.dart';
import 'app/data/data_source/remote_data.dart';
import 'app/data/repository/auth_repository_impl.dart';
import 'app/data/repository/profile_repository_impl.dart';
import 'app/data/repository/socket_repository_impl.dart';
import 'app/domain/repository/auth_repository.dart';
import 'app/domain/repository/profile_repository.dart';
import 'app/domain/use_case/connect.dart';
import 'app/domain/use_case/disconnect.dart';
import 'app/domain/use_case/fetch_settings.dart';
import 'app/domain/use_case/get_profile.dart';
import 'app/domain/use_case/login.dart';
import 'app/domain/use_case/register.dart';
import 'app/domain/use_case/save_settings.dart';
import 'app/domain/use_case/update_profile.dart';
import 'app/presentation/bloc/connect/connect_bloc.dart';
import 'config/database/hive_tools.dart';

class DependencyInjection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Bloc
    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        login: sl(),
        register: sl(),
        validateToken: sl(),
        authSubscription: DioTools.registerInterceptors(sl<Dio>()),
        connect: sl(),
        disconnect: sl(),
      ),
    );
    sl.registerFactory<SettingsBloc>(() => SettingsBloc(
          fetchSettings: sl(),
          saveSettings: sl(),
        ));
    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfile: sl(),
        updateProfile: sl(),
      ),
    );
    sl.registerFactory<RoomsBloc>(
      () => RoomsBloc(
        fetchRoomsInfo: sl(),
      ),
    );

    sl.registerFactory<ConnectBloc>(() => ConnectBloc(
      fetchHobbies: sl()
    ));

    // Use case
    sl.registerLazySingleton<Login>(() => Login(authRepository: sl()));
    sl.registerLazySingleton<Register>(() => Register(authRepository: sl()));
    sl.registerLazySingleton<GetProfile>(() => GetProfile(profileRepository: sl()));
    sl.registerLazySingleton<UpdateProfile>(() => UpdateProfile(profileRepository: sl()));
    sl.registerLazySingleton<ValidateToken>(() => ValidateToken(authRepository: sl()));
    sl.registerLazySingleton<FetchSettings>(() => FetchSettings(repository: sl()));
    sl.registerLazySingleton<SaveSettings>(() => SaveSettings(repository: sl()));
    sl.registerLazySingleton<FetchRoomsInfo>(() => FetchRoomsInfo(repository: sl()));
    sl.registerLazySingleton<Connect>(() => Connect(socketRepository: sl()));
    sl.registerLazySingleton<Disconnect>(() => Disconnect(socketRepository: sl()));
    sl.registerLazySingleton<FetchHobbies>(() => FetchHobbies(profileRepository: sl()));

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

    sl.registerLazySingleton<SocketRepository>(
      () => SocketRepositoryImpl(
        socketData: sl(),
      ),
    );

    // Data
    sl.registerLazySingleton<RemoteData>(() => RemoteDataImpl(dio: sl()));
    sl.registerLazySingleton<LocalData>(() => LocalDataImpl(sharedPreferences: sl(), profileBox: sl(), settingsSnapshotBox: sl()));
    sl.registerLazySingleton<SocketData>(() => SocketDataImpl(socket: sl()));

    // 3th service
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => DioTools.dio);
    sl.registerLazySingleton<Socket>(() => AppSocket.socket);

    // Hive
    sl.registerLazySingleton<Box<ProfileModel>>(() => HiveTools.profileBox);
    sl.registerLazySingleton<Box<SettingsSnapshotModel>>(() => HiveTools.settingsSnapshotBox);
  }
}
