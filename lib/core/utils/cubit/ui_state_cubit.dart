import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_state.dart';

class UiStateCubit extends HydratedCubit<UIState> {
  UiStateCubit() : super(UIState.initial());

  void toggleTableView() =>
      emit(state.copyWith(isTableView: !state.isTableView));
  void toggleDarkMode() => emit(state.copyWith(isDarkMode: !state.isDarkMode));

  @override
  UIState fromJson(Map<String, dynamic> json) {
    return UIState(
      isTableView: json['isTableView'] as bool? ?? true,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson(UIState state) {
    return {'isTableView': state.isTableView, 'isDarkMode': state.isDarkMode};
  }
}
