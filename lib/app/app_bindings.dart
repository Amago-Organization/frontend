import 'package:flutter_getit/flutter_getit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulse_post/app/features/data/remocao/repositories/post_repository_impl.dart';
import 'package:pulse_post/app/features/data/remocao/repositories/user_repository_impl.dart';
import 'package:pulse_post/app/core/services/client/client_service.dart';
import 'package:pulse_post/app/core/services/client/client_service_impl.dart';
import 'package:pulse_post/app/core/services/local/local_storage_service.dart';
import 'package:pulse_post/app/core/services/local/local_storage_service_impl.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/core/services/messages/result_message_service_impl.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/post_repository.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/user_repository.dart';
import 'package:pulse_post/app/features/presentation/controllers/posts/post_controller.dart';
import 'package:pulse_post/app/features/presentation/controllers/upload/local_upload_controller.dart';
import 'package:pulse_post/app/features/presentation/controllers/user/user_controller.dart';
import 'package:pulse_post/app/features/presentation/viewmodels/remocao/posts/post_view_model.dart';
import 'package:pulse_post/app/features/presentation/viewmodels/remocao/user/user_view_model.dart';
import 'package:pulse_post/app/core/utils/navigator/navigator_global.dart';

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
    Bind.singleton<UserRepository>(
      (i) => UserRepositoryImpl(clientService: i()),
    ),
    Bind.singleton(
      (i) => UserViewModel(
        userRepository: i(),
        localStorageService: i(),
        resultMessageService: i(),
      ),
    ),
    Bind.singleton((i) => UserController(userViewModel: i())),

    Bind.lazySingleton((i) => LocalUploadController()),

    Bind.singleton<PostRepository>(
      (i) => PostRepositoryImpl(clientService: i()),
    ),
    Bind.singleton(
      (i) => PostViewModel(postRepository: i(), resultMessageService: i()),
    ),
    Bind.singleton((i) => PostController(postViewModel: i())),
  ];
}
