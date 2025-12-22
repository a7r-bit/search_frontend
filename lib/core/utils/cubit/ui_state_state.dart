import 'package:equatable/equatable.dart';

class UIState extends Equatable {
  final bool isTableView;
  final bool isDarkMode;

  const UIState({required this.isTableView, required this.isDarkMode});

  factory UIState.initial() =>
      const UIState(isTableView: true, isDarkMode: false);

  UIState copyWith({bool? isTableView, bool? isDarkMode}) {
    return UIState(
      isTableView: isTableView ?? this.isTableView,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [isTableView, isDarkMode];
}
