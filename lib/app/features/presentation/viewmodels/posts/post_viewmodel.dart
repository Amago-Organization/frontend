// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:pulse_post/app/core/errors/error_handler.dart';

import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/core/usecase/usecase.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:pulse_post/app/features/domain/entities/post_entity.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_register_param.dart';
import 'package:pulse_post/app/features/domain/params/posts/post_update_param.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_detail.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_list_by_file_type.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_register.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_remove.dart';
import 'package:pulse_post/app/features/domain/usecases/posts/post_usecase_update.dart';

part 'post_viewmodel.g.dart';

class PostViewmodel = PostViewmodelBase with _$PostViewmodel;

abstract class PostViewmodelBase with Store {
  final PostUsecaseList postUsecaseList;
  final PostUsecaseListByFileType postUsecaseListByFileType;
  final PostUsecaseDetail postUsecaseDetail;
  final PostUsecaseRegister postUsecaseRegister;
  final PostUsecaseUpdate postUsecaseUpdate;
  final PostUsecaseRemove postUsecaseRemove;

  final ResultMessageService resultMessageService;
  PostViewmodelBase({
    required this.postUsecaseList,
    required this.postUsecaseListByFileType,
    required this.postUsecaseDetail,
    required this.postUsecaseRegister,
    required this.postUsecaseUpdate,
    required this.postUsecaseRemove,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  bool serverError = false;

  @observable
  PostEntity? post;

  @observable
  List<PostEntity>? postList;

  @observable
  List<PostEntity>? postListByFileType;

  @action
  Future<void> list() async {
    isLoading = true;

    final result = await postUsecaseList(NoParams());

    result.fold(
      (success) {
        serverError = false;
        postList = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> listByFileType(String type) async {
    isLoading = true;

    final result = await postUsecaseListByFileType(type);

    result.fold(
      (success) {
        serverError = false;
        postListByFileType = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> detail(String id) async {
    isLoading = true;

    final result = await postUsecaseDetail(id);

    result.fold(
      (success) {
        serverError = false;
        post = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> register(PostRegisterParam data) async {
    isLoading = true;

    final result = await postUsecaseRegister(data);

    result.fold(
      (success) {
        serverError = false;
        resultMessageService.showMessageSuccess(
          TextConstant.sucessRegisterPostTitle,
          TextConstant.sucessRegisterPostMessage,
        );
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> update(PostUpdateParam data) async {
    isLoading = true;

    final result = await postUsecaseUpdate(data);

    result.fold(
      (success) {
        serverError = false;
        resultMessageService.showMessageSuccess(
          TextConstant.sucessRegisterPostTitle,
          TextConstant.sucessRegisterPostMessage,
        );
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }

  @action
  Future<void> remove(String id) async {
    isLoading = true;

    final result = await postUsecaseRemove(id);

    result.fold(
      (success) {
        serverError = false;
        resultMessageService.showMessageSuccess(
          TextConstant.sucessDeletePostTitle,
          TextConstant.sucessDeletePostMessage,
        );
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(getErrorMessage(failure));
      },
    );

    isLoading = false;
  }
}

