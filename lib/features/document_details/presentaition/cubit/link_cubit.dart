import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/domain/failures/failure.dart';

part 'link_state.dart';

class LinkCubit extends Cubit<LinkState> {
  LinkCubit() : super(LinkInitial());

  Future<void> openDocumentLink(String fileUrl) async {
    try {
      final url = "$BASE_URL$fileUrl";
      final uri = Uri.tryParse(url);

      if (uri == null || !await canLaunchUrl(uri)) {
        throw Failure("Невозможно открыть ссылку: $url");
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
      emit(LinkSuccess());
    } catch (e) {
      final message = e is Failure
          ? e.message
          : "Произошла ошибка при открытии ссылки";
      addError(message);
    }
  }
}
