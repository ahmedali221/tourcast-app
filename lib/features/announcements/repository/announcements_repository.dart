import 'package:dio/dio.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';
import 'package:tourguide_app/features/announcements/repository/i_announcements_repository.dart';

class AnnouncementsRepository implements IAnnouncementsRepository {
  final Dio _dio;

  AnnouncementsRepository(this._dio);

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    final response = await _dio.get('/guide/announcements');
    final raw = response.data['data'];
    final list = (raw is Map ? raw['data'] : raw) as List? ?? [];
    return list.map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
