import 'package:equatable/equatable.dart';

class UIState extends Equatable {
  final bool isTableView;
  final bool showDocumentDetailsDetails;

  const UIState({
    required this.isTableView,
    required this.showDocumentDetailsDetails,
  });

  factory UIState.initial() =>
      const UIState(isTableView: true, showDocumentDetailsDetails: true);

  UIState copyWith({bool? isTableView, bool? showDocumentDetailsDetails}) {
    return UIState(
      isTableView: isTableView ?? this.isTableView,
      showDocumentDetailsDetails:
          showDocumentDetailsDetails ?? this.showDocumentDetailsDetails,
    );
  }

  @override
  List<Object> get props => [isTableView, showDocumentDetailsDetails];
}
