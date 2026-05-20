import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';
import 'package:tourguide_app/features/announcements/repository/i_announcements_repository.dart';

// ---------- States ----------

abstract class AnnouncementsState {}

class AnnouncementsInitial extends AnnouncementsState {}

class AnnouncementsLoading extends AnnouncementsState {}

class AnnouncementsLoaded extends AnnouncementsState {
  final List<AnnouncementModel> announcements;
  AnnouncementsLoaded(this.announcements);
}

class AnnouncementsError extends AnnouncementsState {
  final String message;
  AnnouncementsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final IAnnouncementsRepository _repository;

  AnnouncementsCubit(this._repository) : super(AnnouncementsInitial());

  Future<void> loadAnnouncements() async {
    if (isClosed) return;

    // Show cached announcements immediately to avoid loading flicker.
    final cached = await _repository.getCachedAnnouncements();
    if (!isClosed) {
      if (cached != null) {
        emit(AnnouncementsLoaded(cached));
      } else {
        emit(AnnouncementsLoading());
      }
    }

    // Always refresh from network in the background.
    try {
      final announcements = await _repository.getAnnouncements();
      if (!isClosed) emit(AnnouncementsLoaded(announcements));
    } on DioException catch (e) {
      if (cached == null && !isClosed) {
        emit(AnnouncementsError(e.response?.data['message'] ?? 'Failed to load announcements'));
      }
    } catch (_) {
      if (cached == null && !isClosed) {
        emit(AnnouncementsError('Something went wrong. Please try again.'));
      }
    }
  }
}
