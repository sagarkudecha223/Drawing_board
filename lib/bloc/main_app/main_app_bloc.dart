import 'dart:async';
import 'dart:io';
import 'package:flutter_base_architecture_plugin/imports/core_imports.dart';
import '../../services/theme_service/theme_service.dart';
import 'main_app_contract.dart';

class MainAppBloc extends BaseBloc<MainAppEvent, MainAppData> {
  MainAppBloc(this._themeService) : super(initState) {
    on<InitEvent>(_initEvent);
    on<DisposeEvent>(_disposeEvent);
    on<InActiveEvent>(_inActiveEvent);
    on<AppResumedEvent>(_appResumedEvent);
    on<ChangeThemeEvent>(_changeTheme);
    on<UpdateMainAppState>((event, emit) => emit(event.state));
    _observeStreamSubscription();
  }

  final ThemeService _themeService;

  StreamSubscription<bool>? _themeStreamSubscription;

  static MainAppData get initState =>
      (MainAppDataBuilder()
            ..state = ScreenState.loading
            ..isGuestUser = false
            ..isLoggedIn = false
            ..isLightTheme = false)
          .build();

  void _initEvent(_, __) {
    add(
      UpdateMainAppState(
        state.rebuild(
          (u) =>
              u
                ..isLoggedIn = true
                ..isLightTheme = _themeService.getThemeMode()
                ..state = ScreenState.content,
        ),
      ),
    );
  }

  void _inActiveEvent(_, __) => printLog(message: 'App is Inactive');

  void _appResumedEvent(_, __) => printLog(message: 'App is Resume');

  void _disposeEvent(_, __) => exit(0);

  void _changeTheme(_, emit) {
    emit(
      state.rebuild((u) {
        _themeService.changeThemeMode();
        u.isLightTheme = _themeService.getThemeMode();
      }),
    );
    dispatchViewEvent(ChangeTheme());
  }

  _observeStreamSubscription() =>
      _themeStreamSubscription = _themeService.notifyThemeChange().listen(
        (isChange) => dispatchViewEvent(ChangeTheme()),
      );

  @override
  Future<void> close() {
    _themeStreamSubscription?.cancel();
    return super.close();
  }
}
