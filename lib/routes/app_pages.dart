import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uchat/core/presentation/bindings/passcode_binding.dart';
import 'package:uchat/core/presentation/screens/passcode_screen.dart';
import 'package:uchat/features/accounts_center/presentation/accounts_center_presentation.dart';
import 'package:uchat/features/accounts_center/presentation/bindings/account_setting_binding.dart';
import 'package:uchat/features/accounts_center/presentation/bindings/select_account_binding.dart';
import 'package:uchat/features/accounts_center/presentation/views/screens/account_setting_screen.dart';
import 'package:uchat/features/accounts_center/presentation/views/screens/select_account_screen.dart';
import 'package:uchat/features/add_contact/presentation/binding/add_contact_binding.dart';
import 'package:uchat/features/add_contact/presentation/binding/add_contact_by_qr_binding.dart';
import 'package:uchat/features/add_contact/presentation/binding/add_contact_search_binding.dart';
import 'package:uchat/features/add_contact/presentation/screens/add_contact_by_qr_screen.dart';
import 'package:uchat/features/add_contact/presentation/screens/add_contact_screen.dart';
import 'package:uchat/features/add_contact/presentation/widgets/add_contact_search.dart';
import 'package:uchat/features/album/presentation/bindings/add_to_album_binding.dart';
import 'package:uchat/features/album/presentation/views/screens/add_to_album_screen.dart';
import 'package:uchat/features/auth/presentation/bindings/create_account_confirm_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/create_account_name_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/create_account_profile_avatar_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/create_account_set_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/create_account_uchat_id_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/forgot_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/forgot_password_get_otp_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/link_account_with_apple_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/link_account_with_email_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/link_account_with_facebook_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/link_account_with_google_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/login_with_phone_number_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_confirm_new_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_create_new_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_email_change_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_email_v2_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_otp_request_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_otp_verify_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_prompt_set_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_send_email_forgot_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_update_apple_id_syncing_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_update_facebook_account_syncing_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_update_google_account_syncing_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/setting_account_validate_password_binding.dart'; // New Import
import 'package:uchat/features/auth/presentation/bindings/setup_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/two_fa_otp_login_receipt_method_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/two_fa_otp_login_request_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/two_fa_otp_login_verify_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/two_fa_otp_receipt_method_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/verify_otp_forgot_password_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/verify_otp_link_email_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/verify_otp_login_binding.dart';
import 'package:uchat/features/auth/presentation/bindings/verify_otp_register_binding.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/2fa/two_fa_otp_login_receipt_method_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/2fa/two_fa_otp_login_request_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/2fa/two_fa_otp_login_verify_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/2fa/two_fa_otp_receipt_method_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_confirm_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_get_otp_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_setup_new_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_setup_success_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_apple_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_email_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_google_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_wth_facebook_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/login/login_with_phone_number_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_confirm_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_name_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_profile_avatar_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_set_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_uchat_id_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/set_up_password/setup_password_confirm_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/set_up_password/setup_password_create_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_apple_id/setting_account_update_apple_id_syncing_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_email/setting_account_email_change_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_email/setting_account_email_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_email/setting_account_email_unregistered_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_facebook_account/setting_account_update_facebook_account_syncing_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_forgot_password/setting_account_sent_email_forgot_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_google_account/setting_account_update_google_account_syncing_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_otp/setting_account_otp_request_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_otp/setting_account_otp_verify_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_password/setting_account_change_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_password/setting_account_confirm_new_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_password/setting_account_create_new_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_password/setting_account_prompt_set_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/setting_account_validate_password/setting_account_validate_password_screen.dart'; // New Import
import 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_forgot_password_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_link_email_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_login_screen.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_register_screen.dart';
import 'package:uchat/features/call_log/presentation/bindings/call_log_screen_binding.dart';
import 'package:uchat/features/call_log/presentation/bindings/call_log_search_screen_binding.dart';
import 'package:uchat/features/call_log/presentation/bindings/call_log_select_screen_binding.dart';
import 'package:uchat/features/call_log/presentation/views/screens/mobile/call_log_screen.dart';
import 'package:uchat/features/call_log/presentation/views/screens/mobile/call_log_search_screen.dart';
import 'package:uchat/features/call_log/presentation/views/screens/mobile/call_log_select_screen.dart';
import 'package:uchat/features/chat_folder/presentation/bindings/chat_folder_create_binding.dart';
import 'package:uchat/features/chat_folder/presentation/bindings/chat_folder_edit_detail_binding.dart';
import 'package:uchat/features/chat_folder/presentation/bindings/chat_folder_edit_list_binding.dart';
import 'package:uchat/features/chat_folder/presentation/screens/chat_folder_create_screen.dart';
import 'package:uchat/features/chat_folder/presentation/screens/chat_folder_edit_detail_screen.dart';
import 'package:uchat/features/chat_folder/presentation/screens/chat_folder_edit_list_screen.dart';
import 'package:uchat/features/chat_folder/presentation/screens/chat_folder_screen.dart';
import 'package:uchat/features/chat_room/presentation/bindings/chat_room_bookmark_binding.dart';
import 'package:uchat/features/chat_room/presentation/bindings/chat_room_direct_binding.dart';
import 'package:uchat/features/chat_room/presentation/bindings/chat_room_group_binding.dart';
import 'package:uchat/features/chat_room/presentation/bindings/chat_room_secret_binding.dart';
import 'package:uchat/features/chat_room/presentation/controllers/queue_monitor_dashboard_controller.dart';
import 'package:uchat/features/chat_room/presentation/screens/queue_monitor_dashboard_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/chat_room_bookmark_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/chat_room_direct_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/chat_room_group_screen.dart';
import 'package:uchat/features/chat_room/presentation/views/screens/chat_room_secret_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_admin_add_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_admin_add_select_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_admin_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_admin_edit_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_album_create_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_album_create_confirm_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_album_image_list_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_album_list_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_album_rename_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_direct_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_files_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_edit_name_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_invite_link_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_invite_link_qr_code_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_invite_link_setting_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_permissions_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_group_type_setting_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_links_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_media_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_member_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_owner_transfer_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/chat_room_detail_theme_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/bindings/room_detail_search_binding.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_admin_add_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_admin_add_select_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_admin_edit_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_admin_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_create_confirm_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_create_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_image_list_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_list_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_not_found_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_album_rename_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_direct_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_files_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_edit_name_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_invite_link_qr_code_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_invite_link_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_invite_link_setting_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_permissions_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_group_type_setting_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_links_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_media_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_member_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_owner_transfer_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/chat_room_detail_theme_screen.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/screens/room_detail_search_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/bindings/search/chat_search_messages_binding.dart';
import 'package:uchat/features/chat_room_list/presentation/bindings/search/search_all_contact_result_binding.dart';
import 'package:uchat/features/chat_room_list/presentation/bindings/search/search_all_message_result_binding.dart';
import 'package:uchat/features/chat_room_list/presentation/bindings/search/search_binding.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/create_group/group_create_final_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/chat_list_search_messages_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/chat_search_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/search_all_contact_result_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/search/search_all_message_result_screen.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/presentation/bindings/contacts_search_screen_binding.dart';
import 'package:uchat/features/contact/presentation/views/screens/mobile/contacts_search_screen.dart';
import 'package:uchat/features/notification_debug/presentation/bindings/notification_debug_binding.dart';
import 'package:uchat/features/notification_debug/presentation/screens/message_state_log_details_screen.dart';
import 'package:uchat/features/notification_debug/presentation/screens/notification_debug_screen.dart';
import 'package:uchat/features/notification_debug/presentation/screens/notification_event_detail_screen.dart';
import 'package:uchat/features/profile/presentation/bindings/profile_binding.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/features/profile/presentation/views/screens/mobile/passcode/passcode_toggle_screen.dart';
import 'package:uchat/features/setting/presentation/setting_presentation.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_favorite_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_gift_choose_friend_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_manage_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_pack_detail_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_search_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_setting_gift_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_setting_purchase_history_binding.dart';
import 'package:uchat/features/sticker/presentation/bindings/sticker_store_binding.dart';
import 'package:uchat/features/sticker/presentation/views/screens/my_sticker/sticker_setting_edit_my_sticker_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/my_sticker/sticker_setting_my_sticker_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_favorite/sticker_favorite_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_gift_choose_friend/sticker_gift_choose_friend_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_pack_detail/sticker_pack_detail_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_search/sticker_search_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_setting/sticker_setting_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_setting_gift/sticker_setting_gift_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_setting_purchase_history/sticker_setting_purchase_history_screen.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/sticker_store_screen.dart';
import 'package:uchat/features/troubleshoot/event_monitor/presentation/screens/event_monitor_screen.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/screens/setting_language/setting_change_language_binding.dart';
import 'package:uchat/screens/setting_privacy_policy/setting_privacy_policy_binding.dart';
import 'package:uchat/screens/setting_privacy_policy/setting_privacy_policy_screen.dart';
import 'package:uchat/screens/setting_terms_and_conditions/setting_terms_and_conditions_binding.dart';
import 'package:uchat/screens/setting_terms_and_conditions/setting_terms_and_conditions_screen.dart';

part 'app_routes.dart';

class AppPages {
  static Transition getTransition() {
    if (GetPlatform.isIOS) {
      return Transition.native;
    }

    return Transition.native;
  }

  static Transition getDialogTransition() {
    if (GetPlatform.isIOS) {
      return Transition.topLevel;
    }

    return Transition.native;
  }

  static Transition getCallTransition() {
    if (GetPlatform.isIOS) {
      return Transition.cupertinoDialog;
    }

    return Transition.native;
  }

  static double gestureWidth(BuildContext _) {
    return Get.width * 0.25;
  }

  static List<GetPage> getRoutes() {
    return [
      ///
      /// Login-Logout-Register
      ///
      GetPage(
        name: Routes.loginWithEmail,
        page: () => const LoginWithEmailScreen(),
        binding: LoginWithEmailBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.loginPassword,
        page: () => const LoginPasswordScreen(),
        binding: LoginPasswordBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.loginWelcome,
        page: () => const LoginWelcomeScreen(),
        binding: LoginWelcomeBinding(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: Routes.otpGetToResetPassword,
        page: () => const ForgotPasswordGetOtpScreen(),
        binding: ForgotPasswordGetOtpBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.logout,
        page: () => const LogoutScreen(),
        binding: LogoutBinding(),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: Routes.passcodeToggle,
        page: () => const PasscodeToggleScreen(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.passcode,
        page: () => const PasscodeScreen(),
        binding: PasscodeBinding(),
        popGesture: false,
        opaque: false,
        fullscreenDialog: true,
        transition: AppPages.getDialogTransition(),
      ),

      ///
      /// Contact
      ///
      GetPage(
        name: Routes.addContact,
        page: () => const AddContactScreen(),
        binding: AddContactBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.addContactSearch,
        page: () => const AddContactSearch(),
        binding: AddContactSearchBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.addContactByQr,
        page: () => const AddContactByQrScreen(),
        binding: AddContactByQrBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.universalSearchMain,
        page: () => const ChatSearchScreen(),
        binding: ChatSearchBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.searchAllContactResult,
        page: () => const SearchAllContactResultScreen(),
        binding: SearchAllContactResultBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.searchAllMessageResult,
        page: () => const SearchAllMessageResultScreen(),
        binding: SearchAllMessageResultBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.universalSearchRoomMessages,
        page: () => const ChatListSearchMessageScreen(),
        binding: ChatSearchMessagesBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.contactsSearchScreen,
        page: () => const ContactsSearchScreen(),
        binding: ContactsSearchScreenBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.callLogSearchScreen,
        page: () => const CallLogSearchScreen(),
        binding: CallLogSearchScreenBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.callLogSelectScreen,
        page: () => const CallLogSelectScreen(),
        binding: CallLogSelectScreenBinding(),
        transition: AppPages.getTransition(),
      ),

      // GetPage(
      //   name: Routes.contactSelection,
      //   page: () => const ContactSelectionScreen(),
      //   binding: ContactSelectionBinding(),
      //   transition: AppPages.getTransition(),
      // ),
      GetPage(
        name: Routes.mobileContacts,
        page: () => const MobileContactListScreen(),
        binding: MobileContactBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.contactSelection,
        page: () => const SelectMemberScreen(),
        binding: SelectMemberBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Group
      ///
      GetPage(
        name: Routes.groupCreate,
        page: () => const SelectMemberScreen(),
        binding: SelectMemberBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.groupCreateFinal,
        page: () => const GroupCreateFinalScreen(),
        binding: GroupCreateFinalBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.groupProfilePicker,
        page: () => const GroupProfilePickerScreen(),
        binding: GroupProfilePickerBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Home
      ///
      GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        transition: AppPages.getTransition(),
        //middle
      ),
      GetPage(
        name: Routes.callLog,
        page: () => const CallLogScreen(),
        binding: CallLogScreenBinding(),
        transition: AppPages.getTransition(),
      ),

      GetPage(
        name: Routes.myQrCode,
        page: () => const MyQrCodeScreen(),
        binding: MyQrCodeBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Photo viewer
      ///
      GetPage(
        name: Routes.photoViewer,
        page: () => const PhotoViewerScreen(),
        binding: PhotoViewerBinding(),
        transition: AppPages.getDialogTransition(),
        fullscreenDialog: true,
        opaque: false,
      ),

      ///
      /// GroupInvite
      ///
      GetPage(
        name: Routes.groupInvite,
        page: () => const GroupInviteScreen(),
        binding: GroupInviteScreenBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Profile
      ///
      GetPage(
        name: Routes.profileNickname,
        page: () => const ProfileNicknameScreen(),
        binding: ProfileNicknameBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      // TODO This GetPage is unused. All profile screen used GetBuilder. remove this ?
      GetPage(
        name: Routes.profile,
        page: () => const ProfileScreenV2(),
        binding: ProfileBindingV2(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.groupProfile,
        page: () => const ProfileGroupScreen(),
        binding: GroupProfileBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.myProfile,
        page: () => const MyProfileScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingMyProfile,
        page: () => const SettingMyProfileScreen(),
        binding: SettingMyProfileBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      ///
      /// Room
      ///
      GetPage(
        name: Routes.roomDetailDirect,
        page: () => ChatRoomDetailDirectScreen(),
        binding: ChatRoomDetailDirectBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroup,
        page: () => ChatRoomDetailGroupScreen(),
        binding: ChatRoomDetailGroupBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailEditTheme,
        page: () => ChatRoomDetailThemeScreen(),
        binding: ChatRoomDetailThemeBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroupTypeSetting,
        page: () => const ChatRoomDetailGroupTypeSettingScreen(),
        binding: ChatRoomDetailGroupTypeSettingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroupInviteLink,
        page: () => const ChatRoomDetailGroupInviteLinkScreen(),
        binding: ChatRoomDetailGroupInviteLinkBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroupInviteLinkSetting,
        page: () => const ChatRoomDetailGroupInviteLinkSettingScreen(),
        binding: ChatRoomDetailGroupInviteLinkSettingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroupInviteLinkQrCode,
        page: () => const ChatRoomDetailGroupInviteLinkQrCodeScreen(),
        binding: ChatRoomDetailGroupInviteLinkQrCodeBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailGroupEditName,
        page: () => const ChatRoomDetailGroupEditNameScreen(),
        binding: ChatRoomDetailGroupEditNameBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailMember,
        page: () => ChatRoomDetailMemberScreen(),
        binding: ChatRoomDetailMemberBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailMemberInvite,
        page: () => const SelectMemberScreen(),
        binding: SelectMemberBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAdmin,
        page: () => ChatRoomDetailAdminScreen(),
        binding: ChatRoomDetailAdminBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailOwnerTransfer,
        page: () => ChatRoomDetailOwnerTransferScreen(),
        binding: ChatRoomDetailOwnerTransferBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAdminAddSelect,
        page: () => ChatRoomDetailAdminAddSelectScreen(),
        binding: ChatRoomDetailAdminAddSelectBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAdminAdd,
        page: () => ChatRoomDetailAdminAddScreen(),
        binding: ChatRoomDetailAdminAddBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAdminEdit,
        page: () => ChatRoomDetailAdminEditScreen(),
        binding: ChatRoomDetailAdminEditBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailGroupPermissions,
        page: () => ChatRoomDetailGroupPermissionsScreen(),
        binding: ChatRoomDetailGroupPermissionsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      ///
      /// Rooms
      ///
      GetPage(
        name: Routes.roomsCreate,
        page: () => const CreateChatScreen(),
        binding: CreateChatBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomsEdit,
        page: () => const RoomsEditScreen(),
        binding: RoomsEditBinding(),
        transition: AppPages.getTransition(),
        fullscreenDialog: true,
      ),
      GetPage(
        name: Routes.chatRoomDirect,
        page: () => ChatRoomDirectScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDirectBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.chatRoomGroup,
        page: () => ChatRoomGroupScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomGroupBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.chatRoomSecret,
        page: () => ChatRoomSecretScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomSecretBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.chatRoomBookmark,
        page: () => ChatRoomBookmarkScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomBookmarkBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.queueMonitorDashboard,
        page: () => const QueueMonitorDashboardScreen(),
        binding: BindingsBuilder(() {
          final args = Get.arguments as QueueMonitorArguments;
          Get.lazyPut(
            () => QueueMonitorDashboardController(
              roomId: args.roomId,
              controllerTag: args.controllerTag,
              roomName: args.roomName,
            ),
          );
        }),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailSearch,
        page: () => RoomDetailSearchScreen(),
        binding: RoomDetailSearchBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.roomDetailAlbumCreate,
        page: () => ChatRoomDetailAlbumCreateScreen(
          controllerTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailAlbumCreateBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAlbumCreateConfirm,
        page: () => ChatRoomDetailAlbumCreateConfirmScreen(
          controllerTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailAlbumCreateConfirmBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAlbumRename,
        page: () => ChatRoomDetailAlbumRenameScreen(
          controllerTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailAlbumRenameBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAlbumImageList,
        page: () => ChatRoomDetailAlbumImageListScreen(
          controllerTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailAlbumImageListBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAlbumList,
        page: () => ChatRoomDetailAlbumListScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailAlbumListBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailAlbumNotFound,
        page: () => const ChatRoomDetailAlbumNotFoundScreen(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailMedia,
        page: () => ChatRoomDetailMediaScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailMediaBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailFiles,
        page: () => ChatRoomDetailFilesScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailFilesBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.roomDetailLinks,
        page: () => ChatRoomDetailLinksScreen(
          roomTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: ChatRoomDetailLinksBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.addToAlbum,
        page: () => AddToAlbumScreen(
          controllerTag: Get.parameters['id'] ?? 'NEW_ROOM',
        ),
        binding: AddToAlbumBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Setting
      ///
      GetPage(
        name: Routes.setting,
        page: () => const SettingsScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingFriendChatCall,
        page: () => const SettingFriendChatCallScreen(),
        binding: SettingFriendChatCallBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingCall,
        page: () => const SettingCallScreen(),
        binding: SettingCallBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingChat,
        page: () => const SettingChatsScreen(),
        binding: SettingChatsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingChatAnimation,
        page: () => const SettingChatsAnimationScreen(),
        binding: SettingChatsAnimationBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingChatSound,
        page: () => const SettingChatsSoundScreen(),
        binding: SettingChatsSoundBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingChatHidden,
        page: () => const SettingHiddenChatsScreen(),
        binding: SettingHiddenChatsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingFriend,
        page: () => const SettingFriendsScreen(),
        binding: SettingFriendsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingFriendBlock,
        page: () => const SettingBlockFriendsScreen(),
        binding: SettingBlockFriendsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingFriendHidden,
        page: () => const SettingHiddenFriendsScreen(),
        binding: SettingHiddenFriendsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingChangeLanguage,
        page: () => const SettingChangeLanguageScreen(),
        binding: SettingChangeLanguageBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingHelpCenter,
        page: () => const SettingHelpCenterScreen(),
        binding: SettingHelpCenterBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingPrivacyPolicy,
        page: () => const SettingPrivacyPolicyScreen(),
        binding: SettingPrivacyPolicyBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingTermsAndConditions,
        page: () => const SettingTermsAndConditionsScreen(),
        binding: SettingTermsAndConditionsBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingTroubleshoot,
        page: () => const SettingTroubleshootScreen(),
        binding: SettingTroubleshootBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.troubleshootEventMonitor,
        page: () => const EventMonitorScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingTalker,
        page: () => const SettingTalkerScreen(),
        binding: SettingTalkerBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.accountsCenter,
        page: () => const AccountsCenterScreen(),
        binding: AccountsCenterBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.accountSetting,
        page: () => const AccountSettingScreen(),
        binding: AccountSettingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.selectAccount,
        page: () => const SelectAccountScreen(),
        binding: SelectAccountBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountEmailUnregistered,
        page: () => const SettingAccountEmailUnregisteredScreen(),
        binding: SettingAccountEmailV2Binding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountEmailChange,
        page: () => const SettingAccountEmailChangeScreen(),
        binding: SettingAccountEmailChangeBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountValidatePassword,
        page: () => const SettingAccountValidatePasswordScreen(),
        binding: SettingAccountValidatePasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountEmailV2,
        page: () => const SettingAccountEmailScreenV2(),
        binding: SettingAccountEmailV2Binding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountChangePassword,
        page: () => const SettingAccountChangePasswordScreen(),
        binding: SettingAccountPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingAccountPromptSetPassword,
        page: () => const SettingAccountPromptSetPasswordScreen(),
        binding: SettingAccountPromptSetPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingAccountCreateNewPassword,
        page: () => const SettingAccountCreateNewPasswordScreen(),
        binding: SettingAccountCreateNewPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingAccountConfirmNewPassword,
        page: () => const SettingAccountConfirmNewPasswordScreen(),
        binding: SettingAccountConfirmNewPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.settingAccountSentEmailForgotPassword,
        page: () => const SettingAccountSentEmailForgotPasswordScreen(),
        binding: SettingAccountSentEmailForgotPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountUpdateGoogleAccount,
        page: () => const SettingAccountUpdateGoogleAccountSyncingScreen(),
        binding: SettingAccountUpdateGoogleAccountSyncingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountUpdateAppleId,
        page: () => const SettingAccountUpdateAppleIdSyncingScreen(),
        binding: SettingAccountUpdateAppleIdSyncingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountUpdateFacebookAccount,
        page: () => const SettingAccountUpdateFacebookAccountSyncingScreen(),
        binding: SettingAccountUpdateFacebookAccountSyncingBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingChangeFont,
        page: () => const SettingChangeFontScreen(),
        binding: SettingChangeFontBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.aboutApp,
        page: () => const SettingAboutAppScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountPhoneNumber,
        page: () => const SettingAccountPhoneNumberScreen(),
        binding: SettingAccountPhoneNumberBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingAccountPhoneNumberChange,
        page: () => const SettingAccountPhoneNumberChangeScreen(),
        binding: SettingAccountPhoneNumberChangeBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.settingDevicesManager,
        page: () => const SettingDevicesManagerScreen(),
        binding: SettingDevicesManagerBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.forgotPasswordSetupNewPassword,
        page: () => const ForgotPasswordSetupNewPasswordScreen(),
        binding: ForgotPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.forgotPasswordSetupNewPasswordConfirm,
        page: () => const ForgotPasswordConfirmScreen(),
        binding: ForgotPasswordBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.forgotPasswordSetupSuccess,
        page: () => const ForgotPasswordSetupSuccessScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      ///
      /// UCHAT Coins
      ///
      ///
      GetPage(
        name: Routes.coinStore,
        page: () => const CoinStoreScreen(),
        binding: CoinStoreBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.coinHistory,
        page: () => const CoinHistoryScreen(),
        binding: CoinHistoryBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      ///
      /// Sticker
      ///
      GetPage(
        name: Routes.stickerFavorite,
        page: () => const StickerFavoriteScreen(),
        binding: StickerFavoriteBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSetting,
        page: () => const StickerSettingScreen(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSettingMySticker,
        page: () => const StickerSettingMyStickerScreen(),
        binding: StickerManageBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSettingPurchaseHistory,
        page: () => const StickerSettingPurchaseHistoryScreen(),
        binding: StickerSettingPurchaseHistoryBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSettingGift,
        page: () => const StickerSettingGiftScreen(),
        binding: StickerSettingGiftBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSettingEditMySticker,
        page: () => const StickerSettingEditMyStickerScreen(),
        binding: StickerManageBinding(),
        transition: AppPages.getTransition(),
      ),

      GetPage(
        name: Routes.stickerStore,
        page: () => const StickerStoreScreen(),
        binding: StickerStoreBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerDetail,
        page: () => StickerPackDetailScreen(
          stickerPackId: Get.parameters['stickerPackId'],
        ),
        binding: StickerPackDetailBinding(),
        transition: AppPages.getTransition(),
      ),

      GetPage(
        name: Routes.roomStickerDetail,
        page: () => const StickerPackDetailScreen(),
        binding: StickerPackDetailBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerGiftChooseFriend,
        page: () => const StickerGiftChooseFriendScreen(),
        binding: StickerGiftChooseFriendBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.stickerSearch,
        page: () => const StickerSearchScreen(),
        binding: StickerSearchBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Splash
      ///
      GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Welcome
      ///
      GetPage(
        name: Routes.welcome,
        page: () => const WelcomeScreen(),
        binding: WelcomeBinding(),
        transition: Transition.fadeIn,
      ),

      ///
      /// Room
      ///
      GetPage(
        name: Routes.formTextbox,
        page: () => const FormTextboxScreen(),
        binding: FormTextboxBinding(),
        transition: AppPages.getTransition(),
      ),

      ///
      /// Google map
      ///
      GetPage(
        name: Routes.map,
        page: () => const MapScreen(),
        binding: MapBinding(),
        transition: AppPages.getTransition(),
      ),

      /// secret room
      GetPage(
        name: Routes.secretChatSetting,
        page: () => const SecretChatSettingScreen(),
        binding: SecretChatSettingBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.secretChatSettingDuration,
        page: () => const SecretChatSettingDurationScreen(),
        binding: SecretChatSettingDurationBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingNotification,
        page: () => const SettingNotificationScreen(),
        binding: SettingNotificationBinding(),
        transition: AppPages.getTransition(),
      ),

      /// Premium package pages
      GetPage(
        name: Routes.settingPremiumPacksStore,
        page: () => const PremiumPackagesStoreScreen(),
        binding: PremiumPackagesStoreBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingPremiumPacksCompareStore,
        page: () => const PremiumPackageCompareScreen(),
        binding: PremiumPackageCompareBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingPremiumPacksDetail,
        page: () => const PremiumPackageDetailScreen(),
        binding: PremiumPackageDetailBinding(),
        transition: AppPages.getTransition(),
        fullscreenDialog: true,
      ),
      GetPage(
        name: Routes.createAccountName,
        page: () => const CreateAccountNameScreen(),
        binding: CreateAccountNameBinding(),
      ),
      GetPage(
        name: Routes.createAccountSetPassword,
        page: () => const CreateAccountSetPasswordScreen(),
        binding: CreateAccountSetPasswordBinding(),
      ),
      GetPage(
        name: Routes.createAccountConfirmPassword,
        page: () => const CreateAccountConfirmPasswordScreen(),
        binding: CreateAccountConfirmPasswordBinding(),
      ),
      GetPage(
        name: Routes.createAccountUChatID,
        page: () => const CreateAccountUChatIDScreen(),
        binding: CreateAccountUChatIDBinding(),
      ),
      GetPage(
        name: Routes.createAccountProfileAvatar,
        page: () => const CreateAccountProfileAvatarScreen(),
        binding: CreateAccountProfileAvatarBinding(),
      ),
      GetPage(
        name: Routes.loginWithPhoneNumber,
        page: () => const LoginWithPhoneNumberScreen(),
        binding: LoginWithPhoneNumberBinding(),
        transition: AppPages.getTransition(),
      ),

      // GetPage(
      //   name: Routes.selectedAlbum,
      //   page: () => const GallerySelected(),
      //   binding: GalleryPickerBinding(),
      //   transition: Transition.downToUp,
      // )

      GetPage(
        name: Routes.chatFolder,
        page: () => const ChatFolderScreen(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.chatFolderEditList,
        page: () => const ChatFolderEditListScreen(),
        binding: ChatFolderEditListBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.chatFolderCreate,
        page: () => ChatFolderCreateScreen(),
        binding: ChatFolderCreateBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.chatFolderEditDetail,
        page: () => ChatFolderEditDetailScreen(
          folderId: Get.parameters['id'] ?? 'NEW_FOLDER',
        ),
        binding: ChatFolderEditDetailBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.chatFolderSelectRoom,
        page: () => const SelectMemberScreen(),
        binding: SelectMemberBinding(),
        transition: AppPages.getTransition(),
      ),

      GetPage(
        name: Routes.settingPremiumPackage,
        page: () => const SettingPremiumPackageScreen(),
        binding: SettingPremiumPackageBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.premiumCancel,
        page: () => const PremiumCancelScreen(),
        binding: PremiumCancelBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),

      GetPage(
        name: Routes.subscriptionList,
        page: () => const SubscriptionListScreen(),
        binding: SubscriptionListBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.setupPasswordNew,
        page: () => const SetupPasswordCreateScreen(),
        binding: SetupPasswordBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.setupPasswordNewConfirm,
        page: () => const SetupPasswordConfirmScreen(),
        binding: SetupPasswordBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.linkAccountWithFacebook,
        page: () => const LinkAccountWthFacebookScreen(),
        binding: LinkAccountWithFacebookBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.linkAccountWithGoogle,
        page: () => const LinkAccountWithGoogleScreen(),
        binding: LinkAccountWithGoogleBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.linkAccountWithApple,
        page: () => const LinkAccountWithAppleScreen(),
        binding: LinkAccountWithAppleBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.linkAccountWithEmail,
        page: () => const LinkAccountWithEmailScreen(),
        binding: LinkAccountWithEmailBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.verifyOtpLogin,
        page: () => const VerifyOtpLoginScreen(),
        binding: VerifyOtpLoginBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.verifyOtpRegister,
        page: () => const VerifyOtpRegisterScreen(),
        binding: VerifyOtpRegisterBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.verifyOtpLinkEmail,
        page: () => const VerifyOtpLinkEmailScreen(),
        binding: VerifyOtpLinkEmailBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.verifyOtpForgotPassword,
        page: () => const VerifyOtpForgotPasswordScreen(),
        binding: VerifyOtpForgotPasswordBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.twoFaOtpReceiptMethod,
        page: () => const TwoFaOtpReceiptMethodScreen(),
        binding: TwoFaOtpReceiptMethodBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.twoFaOtpLoginReceiptMethod,
        page: () => const TwoFaOtpLoginReceiptMethodScreen(),
        binding: TwoFaOtpLoginReceiptMethodBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.twoFaOtpLoginVerify,
        page: () => const TwoFaOtpLoginVerifyScreen(),
        binding: TwoFaOtpLoginVerifyBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.twoFaOtpLoginRequest,
        page: () => const TwoFaOtpLoginRequestScreen(),
        binding: TwoFaOtpLoginRequestBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingAccountOtpRequest,
        page: () => const SettingAccountOtpRequestScreen(),
        binding: SettingAccountOtpRequestBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.settingAccountOtpVerify,
        page: () => const SettingAccountOtpVerifyScreen(),
        binding: SettingAccountOtpVerifyBinding(),
        transition: AppPages.getTransition(),
      ),

      ///New Edit Room
      GetPage(
        name: Routes.newEditRoom,
        page: () => const ChatRoomListEditScreen(),
        binding: ChatRoomListEditBinding(),
        transition: AppPages.getTransition(),
      ),
      GetPage(
        name: Routes.notificationDebug,
        page: () => const NotificationDebugScreen(),
        binding: NotificationDebugBinding(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.notificationDebugLogDetails,
        page: () => const NotificationEventDetailScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
      GetPage(
        name: Routes.messageStateLogDetails,
        page: () => const MessageStateLogDetailsScreen(),
        transition: AppPages.getTransition(),
        gestureWidth: gestureWidth,
      ),
    ];
  }
}
