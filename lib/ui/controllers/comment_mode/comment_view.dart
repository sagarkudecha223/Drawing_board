import 'package:flutter/material.dart';
import 'package:flutter_base_architecture_plugin/imports/extension_imports.dart';
import 'package:gap/gap.dart';

import '../../../bloc/drawing_board/drawing_board_bloc.dart';
import '../../../bloc/drawing_board/drawing_board_contract.dart';
import '../../../core/colors.dart';
import '../../../core/dimens.dart';
import '../../../core/enum.dart';
import '../../../core/images.dart';
import '../../common/svg_icon.dart';
import '../../painter/drawing_painter.dart';
import 'comment_model.dart';

class CommentView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const CommentView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (bloc.state.drawingMode == DrawingMode.commentMode)
          GestureDetector(
            onTapUp: (details) {
              bloc.state.commentPosition == null
                  ? bloc.add(ShowAddCommentEvent(tapUpDetails: details))
                  : bloc.add(OutSideTapEvent());
            },
            child: CustomPaint(
              painter: DrawingPainter(bloc.state.drawingController),
              size: Size.infinite,
            ),
          ),
        if (bloc.state.commentPosition != null)
          Positioned(
            left: bloc.state.commentPosition!.dx,
            top: bloc.state.commentPosition!.dy,
            child: _ChatInputView(bloc: bloc),
          ),
        Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children:
              bloc.state.listOfComments
                  .map(
                    (comment) => Positioned(
                      left: comment.position.dx,
                      top: comment.position.dy,
                      child: _ChatBubbleInfo(bloc: bloc, comment: comment),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _ChatInputView extends StatelessWidget {
  final DrawingBoardBloc bloc;

  const _ChatInputView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppSvgIcon(
          Images.commentFill,
          height: 30,
          color: AppColors.pastelBlue,
        ),
        const Gap(Dimens.space3xSmall),
        _AppTextField(
          controller: bloc.state.commentController,
          autoFocus: true,
          onSubmitted: (text) {
            if (text.isNotEmpty) {
              bloc.add(AddCommentEvent());
            } else {
              bloc.add(OutSideTapEvent());
            }
          },
        ),
      ],
    );
  }
}

class _ChatBubbleInfo extends StatelessWidget {
  final DrawingBoardBloc bloc;
  final CommentModel comment;

  const _ChatBubbleInfo({required this.bloc, required this.comment});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: comment.globalKey,
      onTap:
          () => showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder:
                (_) => _CommentInfoDialog(
                  comment: comment,
                  bloc: bloc,
                  globalKey: comment.globalKey,
                ),
          ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        children: [
          const AppSvgIcon(
            Images.commentFill,
            height: 30,
            color: AppColors.primaryBlue2,
          ),
          Text(comment.initial),
        ],
      ),
    );
  }
}

class _CommentInfoDialog extends StatefulWidget {
  final CommentModel comment;
  final DrawingBoardBloc bloc;
  final GlobalKey globalKey;

  const _CommentInfoDialog({
    required this.comment,
    required this.bloc,
    required this.globalKey,
  });

  @override
  State<_CommentInfoDialog> createState() => _CommentInfoDialogState();
}

class _CommentInfoDialogState extends State<_CommentInfoDialog> {
  TextEditingController commentController = TextEditingController();

  RelativeRect? _relativeRect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updatePosition());
  }

  void _updatePosition() {
    if (widget.globalKey.currentContext != null) {
      final renderBox =
          widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      setState(
        () =>
            _relativeRect = RelativeRect.fromLTRB(
              offset.dx,
              offset.dy,
              MediaQuery.of(context).size.width - offset.dx - size.width,
              0.0,
            ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updatePosition();
  }

  @override
  Widget build(BuildContext context) {
    if (_relativeRect == null) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        Positioned(
          left: _relativeRect!.left,
          top: _relativeRect!.top,
          child: Material(
            color: AppColors.transparent,
            child: Container(
              padding: const EdgeInsets.all(Dimens.space2xSmall),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.radiusSmall),
                ),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: AppColors.shadowColor,
                    blurRadius: 4,
                  ),
                ],
              ),
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comment',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.bloc.add(
                            DeleteCommentEvent(commentModel: widget.comment),
                          );
                          context.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.lightRed),
                          ),
                          padding: const EdgeInsets.all(Dimens.space3xSmall),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: AppColors.lightRed,
                            size: Dimens.iconXSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.lightTextMedium,
                    height: 8,
                    thickness: 0.5,
                  ),
                  ListView.separated(
                    separatorBuilder:
                        (_, __) => Divider(
                          color: AppColors.lightTextMedium,
                          height: 8,
                          thickness: 0.5,
                        ),
                    itemCount: widget.comment.comments.length,
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => Text(
                          '${index + 1}. ${widget.comment.comments[index]}',
                          style: TextStyle(color: AppColors.lightTextHigh),
                        ),
                  ),
                  const Gap(20),
                  _AppTextField(
                    controller: commentController,
                    onSubmitted:
                        (text) => setState(() {
                          if (commentController.text.isNotEmpty) {
                            widget.comment.comments.add(text);
                          }
                          commentController.clear();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String text) onSubmitted;
  final bool autoFocus;

  const _AppTextField({
    required this.controller,
    required this.onSubmitted,
    this.autoFocus = false,
  });

  _border() => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(Dimens.radius2xSmall)),
    borderSide: BorderSide(color: AppColors.secondaryGrey2, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        style: TextStyle(color: AppColors.lightTextHigh),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          isDense: true,
          constraints: BoxConstraints(maxHeight: Dimens.textFieldHeightSmall),
          enabledBorder: _border(),
          focusedBorder: _border(),
          border: _border(),
          hintText: 'Add comment...',
          hintStyle: TextStyle(color: AppColors.lightTextHigh),
        ),
        onSubmitted: (text) => onSubmitted(text),
      ),
    );
  }
}
