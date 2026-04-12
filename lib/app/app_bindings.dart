import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:amago/app/core/services/client/client_service.dart';
import 'package:amago/app/core/services/client/client_service_impl.dart';
import 'package:amago/app/core/services/local/local_storage_service.dart';
import 'package:amago/app/core/services/local/local_storage_service_impl.dart';
import 'package:amago/app/core/services/messages/result_message_service.dart';
import 'package:amago/app/core/services/messages/result_message_service_impl.dart';
import 'package:amago/app/features/data/datasources/post/post_datasource.dart';
import 'package:amago/app/features/data/datasources/post/post_datasource_impl.dart';
import 'package:amago/app/features/data/datasources/user/user_datasource.dart';
import 'package:amago/app/features/data/datasources/user/user_datasource_impl.dart';
import 'package:amago/app/features/data/repositories/post_repository_impl.dart';
import 'package:amago/app/features/data/repositories/user_repository_impl.dart';
import 'package:amago/app/features/domain/repositories/post_repository.dart';
import 'package:amago/app/features/domain/repositories/user_repository.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_detail.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_list.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_list_by_file_type.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_register.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_remove.dart';
import 'package:amago/app/features/domain/usecases/posts/post_usecase_update.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_detail.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_login.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_register.dart';
import 'package:amago/app/features/domain/usecases/users/user_usecase_update.dart';
import 'package:amago/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:amago/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:amago/app/features/presentation/controllers/user/user_controller.dart';
import 'package:amago/app/features/presentation/viewmodels/posts/post_viewmodel.dart';
import 'package:amago/app/core/utils/navigator/navigator_global.dart';
import 'package:amago/app/features/presentation/viewmodels/users/user_viewmodel.dart';

class AppBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
    Bind.singleton<LocalStorageService>(
      (i) => LocalStorageServiceImpl(storage: const FlutterSecureStorage()),
    ),
    Bind.singleton<ResultMessageService>(
      (i) =>
          ResultMessageServiceImpl(navigatorKey: NavigatorGlobal.navigatorKey),
    ),
    Bind.singleton<ClientService>((i) => ClientServiceImpl(i())),

    Bind.singleton<UserDatasource>(
      (i) => UserDatasourceImpl(clientService: i()),
    ),

    Bind.singleton<PostDatasource>(
      (i) => PostDatasourceImpl(clientService: i()),
    ),

    Bind.singleton<UserRepository>((i) => UserRepositoryImpl(datasource: i())),
    Bind.singleton<PostRepository>((i) => PostRepositoryImpl(datasource: i())),

    Bind.singleton((i) => UserUsecaseDetail(userRepository: i())),
    Bind.singleton((i) => UserUsecaseLogin(userRepository: i())),
    Bind.singleton((i) => UserUsecaseRegister(userRepository: i())),
    Bind.singleton((i) => UserUsecaseUpdate(userRepository: i())),

    Bind.singleton((i) => PostUsecaseDetail(postRepository: i())),
    Bind.singleton((i) => PostUsecaseListByFileType(postRepository: i())),
    Bind.singleton((i) => PostUsecaseList(postRepository: i())),
    Bind.singleton((i) => PostUsecaseRegister(postRepository: i())),
    Bind.singleton((i) => PostUsecaseRemove(postRepository: i())),
    Bind.singleton((i) => PostUsecaseUpdate(postRepository: i())),

    Bind.singleton(
      (i) => UserViewmodel(
        detailUsecase: i(),
        loginUsecase: i(),
        registerUsecase: i(),
        updateUsecase: i(),
        localStorageService: i(),
        resultMessageService: i(),
      ),
    ),

    Bind.singleton(
      (i) => PostViewmodel(
        postUsecaseDetail: i(),
        postUsecaseList: i(),
        postUsecaseListByFileType: i(),
        postUsecaseRegister: i(),
        postUsecaseRemove: i(),
        postUsecaseUpdate: i(),
        resultMessageService: i(),
      ),
    ),
    Bind.singleton((i) => UserController(userViewmodel: i())),
    Bind.singleton((i) => PostController(postViewmodel: i())),

    Bind.lazySingleton((i) => LocalUploadController()),
  ];
}
