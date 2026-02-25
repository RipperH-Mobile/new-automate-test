import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class RepairContactsWithoutPhoneNumberUseCase extends SimpleUseCase<void, void> {
  final ContactLocalRepository contactLocalRepository;
  final ProfileServerRepository profileServerRepository;
  final LoggerService log;

  RepairContactsWithoutPhoneNumberUseCase({
    required this.contactLocalRepository,
    required this.profileServerRepository,
    required this.log,
  });

  @override
  Future<void> call([void params]) async {
    final contacts = await contactLocalRepository.getContactsWithoutPhoneNumber();

    if (contacts.isEmpty) {
      return;
    }

    final contactsUpdated = await Future.wait(
      contacts.map((contact) async {
        try {
          final profile = await profileServerRepository.getProfile(contact.id ?? '');
          return contact.copyWith(
            id: profile.id,
            username: profile.username,
            phoneNumber: profile.phoneNumber,
            displayName: profile.displayName,
            originalStatusMessage: profile.statusMessage,
            avatarId: profile.avatarId,
            onlineStatus: profile.onlineStatus,
            settings: profile.settings,
            nickname: profile.friendNickname,
          );
        } catch (e, stackTrace) {
          log.w('Failed to repair contact with id: ${contact.id}', e, stackTrace);
          return null; // Return null for failed contacts
        }
      }),
    );

    final validContactsToUpdate = contactsUpdated.whereType<ContactEntity>().toList();
    
    if (validContactsToUpdate.isNotEmpty) {
      await contactLocalRepository.putAllContact(validContactsToUpdate);
    }
  }
}
