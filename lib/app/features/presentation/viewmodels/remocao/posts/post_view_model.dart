// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:mobx/mobx.dart';

import 'package:pulse_post/app/core/services/messages/result_message_service.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_register_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_update_dto.dart';
import 'package:pulse_post/app/features/domain/remocao/repositories/post_repository.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';

part 'post_view_model.g.dart';

class PostViewModel = PostViewModelBase with _$PostViewModel;

abstract class PostViewModelBase with Store {
  final PostRepository postRepository;
  final ResultMessageService resultMessageService;
  PostViewModelBase({
    required this.postRepository,
    required this.resultMessageService,
  });

  @observable
  bool isLoading = false;

  @observable
  bool serverError = false;

  @observable
  PostDetailDto? post;

  @observable
  List<PostDetailDto>? postList;

  @observable
  List<PostDetailDto>? postListByFileType;

  @action
  Future list() async {
    isLoading = true;
    final result = await postRepository.list();
    result.fold(
      (success) {
        serverError = false;
        postList = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future listByFileType(String type) async {
    isLoading = true;
    final result = await postRepository.listByFileType(type);
    result.fold(
      (success) {
        serverError = false;
        postListByFileType = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future register(PostRegisterDto data, File? file) async {
    isLoading = true;
    final result = await postRepository.register(data, file);
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
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future update(String id, PostUpdateDto data, File? file) async {
    isLoading = true;
    final result = await postRepository.update(id, data, file);
    result.fold(
      (success) {
        serverError = false;
        resultMessageService.showMessageSuccess(
          TextConstant.sucessUpdatePostTitle,
          TextConstant.sucessUpdatePostMessage,
        );
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future remove(String id) async {
    isLoading = true;
    final result = await postRepository.remove(id);
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
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }

  @action
  Future detail(String id) async {
    isLoading = true;
    final result = await postRepository.detail(id);
    result.fold(
      (success) {
        serverError = false;
        post = success;
      },
      (failure) {
        serverError = true;
        resultMessageService.showMessageError(
          TextConstant.errorExecutingMessage,
        );
      },
    );
    isLoading = false;
  }
}
