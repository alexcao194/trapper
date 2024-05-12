import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'app/data/data_source/local_data.dart';
import 'app/data/data_source/remote_data.dart';
import 'app/data/data_source/socket_data.dart';
import 'app/data/model/profile_model.dart';
import 'app/data/model/settings_snapshot_model.dart';
import 'app/data/repository/auth_repository_impl.dart';
import 'app/data/repository/profile_repository_impl.dart';
import 'app/data/repository/socket_repository_impl.dart';
import 'app/data/repository/static_repository_impl.dart';
import 'app/domain/repository/auth_repository.dart';
import 'app/domain/repository/profile_repository.dart';
import 'app/domain/repository/socket_repository.dart';
import 'app/domain/repository/static_repository.dart';
import 'app/domain/use_case/add_friend.dart';
import 'app/domain/use_case/cancel_find.dart';
import 'app/domain/use_case/change_password.dart';
import 'app/domain/use_case/reset_password.dart';
import 'app/domain/use_case/connect.dart';
import 'app/domain/use_case/disconnect.dart';
import 'app/domain/use_case/fect_message.dart';
import 'app/domain/use_case/fetch_friends.dart';
import 'app/domain/use_case/fetch_hobbies.dart';
import 'app/domain/use_case/fetch_rooms_info.dart';
import 'app/domain/use_case/fetch_settings.dart';
import 'app/domain/use_case/find_friend.dart';
import 'app/domain/use_case/get_profile.dart';
import 'app/domain/use_case/get_stickers.dart';
import 'app/domain/use_case/listen_connect_status.dart';
import 'app/domain/use_case/listen_friend.dart';
import 'app/domain/use_case/listen_message.dart';
import 'app/domain/use_case/listen_online_friends.dart';
import 'app/domain/use_case/log_out.dart';
import 'app/domain/use_case/login.dart';
import 'app/domain/use_case/post_photo.dart';
import 'app/domain/use_case/register.dart';
import 'app/domain/use_case/save_settings.dart';
import 'app/domain/use_case/send_message.dart';
import 'app/domain/use_case/send_otp.dart';
import 'app/domain/use_case/update_profile.dart';
import 'app/domain/use_case/validate_token.dart';
import 'app/presentation/bloc/auth/auth_bloc.dart';
import 'app/presentation/bloc/connect/connect_bloc.dart';
import 'app/presentation/bloc/friends/friends_bloc.dart';
import 'app/presentation/bloc/home/home_bloc.dart';
import 'app/presentation/bloc/profile/profile_bloc.dart';
import 'app/presentation/bloc/rooms/rooms_bloc.dart';
import 'app/presentation/bloc/settings/settings_bloc.dart';
import 'app/presentation/bloc/sticker/sticker_bloc.dart';
import 'config/database/hive_tools.dart';
import 'config/dio/dio_tools.dart';

class DependencyInjection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Bloc
    sl.registerFactory<HomeBloc>(() => HomeBloc());

    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        login: sl(),
        register: sl(),
        validateToken: sl(),
        authSubscription: DioTools.registerInterceptors(sl<Dio>()),
        connect: sl(),
        disconnect: sl(),
        resetPassword: sl(),
        sendOTP: sl(),
        logout: sl(),
        changePassword: sl(),
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
        postPhoto: sl(),
      ),
    );

    sl.registerFactory<RoomsBloc>(
      () => RoomsBloc(
        fetchRoomsInfo: sl(),
        listenMessage: sl(),
        fetchMessage: sl(),
        sendMessage: sl(),
        listenConnectStatus: sl(),
      ),
    );

    sl.registerFactory<ConnectBloc>(() => ConnectBloc(
          fetchHobbies: sl(),
          findFriend: sl(),
          cancelFind: sl(),
        ));

    sl.registerFactory<FriendsBloc>(() => FriendsBloc(
          fetchFriends: sl(),
          addFriend: sl(),
          listenFriend: sl(),
          listenOnlineFriends: sl(),
        ));

    sl.registerFactory<StickerBloc>(() => StickerBloc(
          getStickers: sl(),
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
    sl.registerLazySingleton<PostPhoto>(() => PostPhoto(repository: sl()));
    sl.registerLazySingleton<FetchFriends>(() => FetchFriends(profileRepository: sl()));
    sl.registerLazySingleton<FindFriend>(() => FindFriend(socketRepository: sl()));
    sl.registerLazySingleton<ListenMessage>(() => ListenMessage(socketRepository: sl()));
    sl.registerLazySingleton<FetchMessage>(() => FetchMessage(socketRepository: sl()));
    sl.registerLazySingleton<SendMessage>(() => SendMessage(socketRepository: sl()));
    sl.registerLazySingleton<CancelFind>(() => CancelFind(repository: sl()));
    sl.registerLazySingleton<AddFriend>(() => AddFriend(socketRepository: sl()));
    sl.registerLazySingleton<ListenFriend>(() => ListenFriend(socketRepository: sl()));
    sl.registerLazySingleton<ListenConnectStatus>(() => ListenConnectStatus(socketRepository: sl()));
    sl.registerLazySingleton<SendOTP>(() => SendOTP(authRepository: sl()));
    sl.registerLazySingleton<ResetPassword>(() => ResetPassword(authRepository: sl()));
    sl.registerLazySingleton<ListenOnlineFriends>(() => ListenOnlineFriends(socketRepository: sl()));
    sl.registerLazySingleton<Logout>(() => Logout(authRepository: sl()));
    sl.registerLazySingleton<GetStickers>(() => GetStickers(staticRepository: sl()));
    sl.registerLazySingleton<ChangePassword>(() => ChangePassword(authRepository: sl()));

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
        remoteData: sl(),
      ),
    );

    sl.registerLazySingleton<StaticRepository>(
      () => StaticRepositoryImpl(
        localData: sl(),
      ),
    );

    // Data
    sl.registerLazySingleton<RemoteData>(() => RemoteDataImpl(dio: sl()));
    sl.registerLazySingleton<LocalData>(() => LocalDataImpl(sharedPreferences: sl(), profileBox: sl(), settingsSnapshotBox: sl()));
    sl.registerLazySingleton<SocketData>(() => SocketDataImpl());

    // 3th service
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => DioTools.dio);

    // Hive
    sl.registerLazySingleton<Box<ProfileModel>>(() => HiveTools.profileBox);
    sl.registerLazySingleton<Box<SettingsSnapshotModel>>(() => HiveTools.settingsSnapshotBox);
  }
}
