// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_post/app/features/presentation/modules/feed/controllers/longText/long_text_controller.dart';
import 'package:pulse_post/app/core/utils/constants/texts/text_constant.dart';
import 'package:uikit/uikit.dart';
import 'package:video_player/video_player.dart';

import 'package:pulse_post/app/features/domain/remocao/dtos/post/post_detail_dto.dart';
import 'package:pulse_post/app/features/domain/enums/post_enum.dart';
import 'package:pulse_post/app/core/utils/constants/icons/icon_constant.dart';

class PostDetailWidget extends StatefulWidget {
  final bool isMyPost;
  final PostDetailDto data;
  const PostDetailWidget({
    super.key,
    this.isMyPost = false,
    required this.data,
  });

  @override
  State<PostDetailWidget> createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  late VideoPlayerController videoPlayerController;
  final longTextController = LongTextController();
  @override
  void initState() {
    super.initState();
    if (widget.data.postType == PostEnum.VIDEO.type) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.data.file!))
            ..initialize().then((_) {
              setState(() {});
            });
    }
  }

  @override
  void dispose() {
    if (widget.data.postType == PostEnum.VIDEO.type) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SizeToken.sm,
            right: SizeToken.sm,
            top: 0,
            bottom: SizeToken.xxs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: SizeToken.sm,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  spacing: SizeToken.xs,
                  children: [
                    ProfileMenuNavDetail(
                      name: widget.data.user.name,
                      image: widget.data.user.image,
                      size: SizeToken.xl,
                    ),
                    Expanded(
                      child: TextLabelL4Dark(
                        text: widget.data.user.name,
                        overflow: true,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              widget.isMyPost
                  ? IconButtonLargeDark(
                      onTap: () =>
                          context.push('/post/update', extra: widget.data),
                      icon: IconConstant.edit,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        widget.data.postType == PostEnum.TEXT.type
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeToken.sm,
                  vertical: SizeToken.xs,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 300,
                    maxWidth: double.infinity,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: SizeToken.xxs,
                    children: [
                      TextLabelL1Dark(text: widget.data.title),
                      TextBodyB1SemiDark(text: widget.data.description),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.data.updatedAt == null
                              ? TextLabelL6SemiDark(
                                  text: TextConstant.createdAt(
                                    DataTimeMask.formatted(
                                      widget.data.createdAt,
                                    ),
                                  ),
                                  maxLines: 1,
                                  overflow: true,
                                )
                              : TextLabelL6SemiDark(
                                  text: TextConstant.updatedAt(
                                    DataTimeMask.formatted(
                                      widget.data.updatedAt!,
                                    ),
                                  ),
                                  maxLines: 1,
                                  overflow: true,
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink(),
        widget.data.postType == PostEnum.IMAGE.type
            ? Padding(
                padding: const EdgeInsets.only(top: SizeToken.xxs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 500,
                        maxWidth: double.infinity,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          widget.data.file.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeToken.sm,
                        vertical: SizeToken.xs,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: SizeToken.xxs,
                        children: [
                          TextLabelL1Dark(text: widget.data.title),
                          Observer(
                            builder: (_) {
                              return InkWell(
                                onTap: () => longTextController.toggleValue(),
                                child: TextBodyB1SemiDark(
                                  text: widget.data.description,
                                  isLimited: longTextController.value,
                                ),
                              );
                            }
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.data.updatedAt == null
                                  ? TextLabelL6SemiDark(
                                      text: TextConstant.createdAt(
                                        DataTimeMask.formatted(
                                          widget.data.createdAt,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: true,
                                    )
                                  : TextLabelL6SemiDark(
                                      text: TextConstant.updatedAt(
                                        DataTimeMask.formatted(
                                          widget.data.updatedAt!,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: true,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),

        widget.data.postType == PostEnum.VIDEO.type
            ? Padding(
                padding: const EdgeInsets.only(top: SizeToken.xxs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: ColorToken.dark,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 500,
                        ),

                        child: AspectRatio(
                          aspectRatio: videoPlayerController.value.isInitialized
                              ? videoPlayerController.value.aspectRatio
                              : 16 / 9,
                          child: buildVideo(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeToken.sm,
                        vertical: SizeToken.xs,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: SizeToken.xxs,
                        children: [
                          TextLabelL1Dark(text: widget.data.title),
                          Observer(
                            builder: (_) {
                              return InkWell(
                                onTap: () => longTextController.toggleValue(),
                                child: TextBodyB1SemiDark(
                                  text: widget.data.description,
                                  isLimited: longTextController.value,
                                ),
                              );
                            }
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.data.updatedAt == null
                                  ? TextLabelL6SemiDark(
                                      text: TextConstant.createdAt(
                                        DataTimeMask.formatted(
                                          widget.data.createdAt,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: true,
                                    )
                                  : TextLabelL6SemiDark(
                                      text: TextConstant.updatedAt(
                                        DataTimeMask.formatted(
                                          widget.data.updatedAt!,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: true,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget buildVideo() {
    if (!videoPlayerController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          videoPlayerController.value.isPlaying
              ? videoPlayerController.pause()
              : videoPlayerController.play();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: videoPlayerController.value.size.width,
                height: videoPlayerController.value.size.height,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          ),
          if (!videoPlayerController.value.isPlaying)
            const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
        ],
      ),
    );
  }
}
