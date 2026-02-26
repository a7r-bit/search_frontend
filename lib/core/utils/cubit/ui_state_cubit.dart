import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_state.dart';

class UiStateCubit extends HydratedCubit<UIState> {
  UiStateCubit() : super(UIState.initial());

  void toggleTableView() =>
      emit(state.copyWith(isTableView: !state.isTableView));

  void toggleShowDocumentDetailsDetails() => emit(
    state.copyWith(
      showDocumentDetailsDetails: !state.showDocumentDetailsDetails,
    ),
  );

  @override
  UIState fromJson(Map<String, dynamic> json) {
    return UIState(
      isTableView: json['isTableView'] as bool? ?? true,
      showDocumentDetailsDetails:
          json['showDocumentDetailsDetails'] as bool? ?? true,
    );
  }

  @override
  Map<String, dynamic> toJson(UIState state) {
    return {
      'isTableView': state.isTableView,
      'showDocumentDetailsDetails': state.showDocumentDetailsDetails,
    };
  }
}
