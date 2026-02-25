// Main export file for the core event bus feature
import 'event_bus_impl.dart';
// Import required classes for global instance
import 'event_tracker.dart';
import 'tracked_event_bus.dart';

export 'event_bus_impl.dart';
export 'event_tracker.dart';
// Event classes
export 'events/accept_request_event.dart';
export 'events/add_failed_message_to_state_event.dart';
export 'events/add_message_to_state_event.dart';
export 'events/add_room_member_event.dart';
export 'events/app_inactive_event.dart';
export 'events/app_resumed_event.dart';
export 'events/bookmark_tag_deleted_event.dart';
export 'events/bookmark_tag_event.dart';
export 'events/call_end_event.dart';
export 'events/call_incoming_event.dart';
export 'events/central_notification_lastseen_update_event.dart';
export 'events/central_notification_update_event.dart';
export 'events/chat_category_unread_update_event.dart';
export 'events/check_email_or_password_not_set_event.dart';
export 'events/close_expanded_text_event.dart';
export 'events/close_slidable_panel_event.dart';
export 'events/close_toast_force_delete_event.dart';
export 'events/contact_delete_event.dart';
export 'events/contact_list_require_refresh_event.dart';
export 'events/contact_update_event.dart';
export 'events/desktop_right_panel_change_event.dart';
export 'events/file_downloader_progress_event.dart';
export 'events/file_downloader_status_event.dart';
export 'events/file_state_change_event.dart';
export 'events/file_upload_progress_event.dart';
export 'events/http_heartbeat_event.dart';
export 'events/jump_to_message_event.dart';
export 'events/lock_message_unlocked_event.dart';
export 'events/maintenance_mode_update_event.dart';
export 'events/message_list_attach_event.dart';
export 'events/message_new_event.dart';
export 'events/message_reaction_event.dart';
export 'events/message_update_event.dart';
export 'events/new_bookmark_tag_event.dart';
export 'events/new_room_after_delete_event.dart';
export 'events/notification_desktop_update_event.dart';
export 'events/notification_opened_event.dart';
export 'events/notification_received_event.dart';
export 'events/oa_menu_publish_event.dart';
export 'events/oa_menu_unpublish_event.dart';
export 'events/on_room_selected_event.dart';
export 'events/open_gallery_event.dart';
export 'events/passcode_activate_event.dart';
export 'events/passcode_checked_event.dart';
export 'events/passcode_launch_event.dart';
export 'events/passcode_prevent_event.dart';
export 'events/passcode_timer_cancel_event.dart';
export 'events/passcode_timer_trigger_event.dart';
export 'events/passcode_update_event.dart';
export 'events/passcode_verify_screen_shown_event.dart';
export 'events/play_new_message_animation_event.dart';
export 'events/remove_room_member_event.dart';
export 'events/reorder_sticker_event.dart';
export 'events/require_friend_request_count_update_event.dart';
export 'events/require_group_invite_update_event.dart';
export 'events/reset_unread_count_local_event.dart';
export 'events/room_delete_event.dart';
export 'events/room_list_require_cancel_db_update_subscribe_event.dart';
export 'events/room_new_event.dart';
export 'events/room_update_event.dart';
export 'events/room_update_subscription_event.dart';
export 'events/socket_connect_error_event.dart';
export 'events/socket_connecting_event.dart';
export 'events/socket_disconnected_event.dart';
export 'events/socket_error_event.dart';
export 'events/socket_packet_loss_event.dart';
export 'events/sticker_update_owner_event.dart';
export 'events/sync_required_event.dart';
export 'events/toggle_failed_message_event.dart';
export 'events/ui_keyboard_update_event.dart';
export 'events/update_image_local.dart';
export 'events/update_room_member_event.dart';
export 'events/user_after_sync_event.dart';
export 'events/user_before_switch_event.dart';
export 'events/user_expired_event.dart';
export 'events/user_in_room_typing_event.dart';
export 'events/user_logged_in_event.dart';
export 'events/user_logged_out_event.dart';
export 'events/user_update_event.dart';
export 'events/video_file_compressing_progress_event.dart';
export 'events/video_play_pause_event.dart';
export 'events/waiting_member_update_event.dart';
export 'events/rich_menu_update_event.dart';
export 'tracked_event_bus.dart';

// Global event bus instance with optional tracking capabilities
late final TrackedEventBus eventBus;

// Initialize event bus (called from main.dart or app initialization)
void initializeEventBus({bool enableTracking = false}) {
  final tracker = EventTracker(
    maxHistorySize: 1000,
    enabled: enableTracking,
  );

  eventBus = TrackedEventBus(
    sync: false,
    tracker: tracker,
    enableTracking: enableTracking,
  );
}

// Get the global event bus instance as regular EventBus for compatibility
EventBus getEventBus() => eventBus;

// Enable/disable event tracking at runtime
void setEventTrackingEnabled(bool enabled) {
  eventBus.setTrackingEnabled(enabled);
}
