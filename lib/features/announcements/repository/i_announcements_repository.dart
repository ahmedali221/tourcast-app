import 'package:tourguide_app/features/announcements/model/announcement_model.dart';

abstract class IAnnouncementsRepository {
  Future<List<AnnouncementModel>> getAnnouncements();
}
