import 'package:chatqu/data/data.dart';
import 'package:chatqu/data/repositories/files_repository_impl.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // cubit
  locator.registerFactory(() => SignInUserCubit(locator()));
  locator.registerFactory(() => SignOutUserCubit(locator()));
  locator.registerFactory(() => SignUpUserCubit(locator()));
  locator.registerFactory(() => SearchUserByUsernameCubit(locator()));
  locator.registerFactory(() => GetUserDataCubit(locator()));
  locator.registerFactory(() => GetUsersListCubit(locator()));
  locator.registerFactory(() => CurrentUserIdCubit(locator()));
  locator.registerFactory(() => GetAllChatCubit(locator()));
  locator.registerFactory(() => SendMessageCubit(locator()));
  locator.registerFactory(() => GetChatMessagesCubit(locator(), locator()));
  locator.registerFactory(() => UploadImageProfileCubit(locator()));

  // use case
  locator.registerLazySingleton(() => SignInUserUseCase(locator()));
  locator.registerLazySingleton(() => SignUpUserUseCase(locator()));
  locator.registerLazySingleton(() => SignOutUserUseCase(locator()));
  locator.registerLazySingleton(() => SearchUserByUsernameUseCase(locator()));
  locator.registerLazySingleton(() => GetUserDataUseCase(locator()));
  locator.registerLazySingleton(() => GetUsersListUseCase(locator()));
  locator.registerLazySingleton(() => CurrentUserIdUseCase(locator()));
  locator.registerLazySingleton(() => GetAllChatUseCase(locator()));
  locator.registerLazySingleton(() => SendMessageUseCase(locator()));
  locator.registerLazySingleton(() => GetChatMessagesUseCase(locator()));
  locator.registerLazySingleton(() => CheckChatExistUseCase(locator()));
  locator.registerLazySingleton(() => UploadImageProfileUseCase(locator()));

  // repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: locator(),
      ));

  locator.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
        chatRemoteDataSource: locator(),
      ));

  locator.registerLazySingleton<FilesRepository>(
      () => FilesRepositoryImpl(filesRemoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
            firebaseAuth: locator(),
            firebaseFirestore: locator(),
          ));

  locator.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(
            firebaseFirestore: locator(),
            firebaseAuth: locator(),
          ));

  locator.registerLazySingleton<FilesRemoteDataSource>(
      () => FilesRemoteDataSourceImpl(
            firebaseFirestore: locator(),
            firebaseStorage: locator(),
          ));

  // external
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
}
