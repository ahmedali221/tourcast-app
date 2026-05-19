import 'package:dio/dio.dart';
import 'package:tourguide_app/core/cache/cache_service.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';
import 'package:tourguide_app/features/announcements/model/announcement_model.dart';
import 'package:tourguide_app/features/announcements/repository/i_announcements_repository.dart';

class AnnouncementsRepository implements IAnnouncementsRepository {
  final Dio _dio;

  AnnouncementsRepository(this._dio);

  @override
  Future<List<AnnouncementModel>?> getCachedAnnouncements() async {
    final cached = await CacheService.getList(
      StorageKeys.announcementsCache,
      ttl: CacheTTL.announcements,
    );
    if (cached == null) return null;
    return cached.map((e) => AnnouncementModel.fromJson(e)).toList();
  }

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    final response = await _dio.get('/guide/announcements');
    final raw = response.data['data'];
    final list = (raw is Map ? raw['data'] : raw) as List? ?? [];
    final jsonList = list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    CacheService.setList(StorageKeys.announcementsCache, jsonList).ignore();
    return jsonList.map((e) => AnnouncementModel.fromJson(e)).toList();
  }
}
