import 'package:uchat/entities/collections.dart';

class StartAnnouncementEvent {
  final List<AnnouncementCollection> announcements;

  StartAnnouncementEvent({required this.announcements});
}
