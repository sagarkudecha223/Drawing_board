import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';

import '../../ui/controllers/drawing_controller/drawing_controller.dart';
import 'drawing_board_contract.dart';

class DrawingBoardBloc extends BaseBloc<DrawingBoardEvent, DrawingBoardData> {
  DrawingBoardBloc() : super(initState) {
    on<InitDrawingBoardEvent>(_initDrawingBoardEvent);
    on<UpdateDrawingBoardState>((event, emit) => emit(event.state));
  }

  static DrawingBoardData get initState =>
      (DrawingBoardDataBuilder()..drawingController = CustomDrawingController())
          .build();

  void _initDrawingBoardEvent(_, __) {}
}
