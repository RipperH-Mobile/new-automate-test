//------------------------------------Arguments for the Chat Room feature------------------------------------------------------------------------
export 'package:uchat/features/chat_room/presentation/arguments/mobile_contact_arguments.dart';

//------------------------------------Bindings for the Chat Room feature------------------------------------------------------------------------
export 'package:uchat/features/chat_room/presentation/bindings/chat_room_bookmark_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/chat_room_direct_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/chat_room_group_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/chat_room_secret_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/map_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
export 'package:uchat/features/chat_room/presentation/bindings/mobile_contact_binding.dart';

//------------------------------------Controllers for the Chat Room feature------------------------------------------------------------------------

// Input
export 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_gif_input_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_sticker_input_controller.dart';

// Message Type Controllers
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_album_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_audio_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_contact_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_file_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_mobile_contact_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_gift_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_sharing_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_text_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_video_v2_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';

// Utils
export 'package:uchat/features/chat_room/presentation/controllers/utils/find_message_index.dart';

// Chat Room Controllers
export 'package:uchat/features/chat_room/presentation/controllers/chat_room_bookmark_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/chat_room_direct_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/chat_room_group_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/chat_room_secret_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/map_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_container_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/mobile_contact_list_screen_controller.dart';
export 'package:uchat/features/chat_room/presentation/controllers/thumbnail_bytes_cache_manager.dart';

//------------------------------------Enums for the Chat Room feature------------------------------------------------------------------------
export 'package:uchat/features/chat_room/presentation/enums/chat_room_keyboard_type.dart';

//------------------------------------Screens for the Chat Room feature------------------------------------------------------------------------

// Desktop
export 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_bookmark_desktop_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_direct_desktop_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_group_desktop_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/desktop/chat_room_secret_desktop_screen.dart';

// Mobile
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_bookmark_mobile_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_direct_mobile_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_group_mobile_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/chat_room_secret_mobile_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/map_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/mobile/mobile_contact_list_screen.dart';

// Common
export 'package:uchat/features/chat_room/presentation/views/screens/chat_room_bookmark_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/chat_room_direct_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/chat_room_group_screen.dart';
export 'package:uchat/features/chat_room/presentation/views/screens/chat_room_secret_screen.dart';

//------------------------------------Widgets for the Chat Room feature------------------------------------------------------------------------

// Input Widgets
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_audio_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_custom_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_gif_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_sticker_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_text_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_mock_message_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/input/debug_send_sequence_message_input.dart';

// Mention Text Field Widgets
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_model.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_text_editing_controller.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_info_model.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_length_map.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_mark_model.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_suggestion_item.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_suggestion_widget.dart';
export 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_text_field.dart';

// Message Image Preview Widgets
export 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_image_element_local.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_image_element.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_local_image_provider.dart';

// Message List Widgets
export 'package:uchat/features/chat_room/presentation/widgets/message_list/always_scrollable_fixed_position_scroll_physics.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_list/date_message_header.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_list/main_message_list.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_list/unread_message_bar.dart';

// Message Type Widgets -- Text Widgets --
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_text_parse.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_emoji.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';

// Message Type Widgets -- Common Widgets --
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_actions.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_album_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_audio_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_call_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_contact_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_file_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_gif_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_link_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_location_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_mobile_contact_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_gift_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_sharing_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_system_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_video_v2.dart';

// Message Video Preview Widgets
export 'package:uchat/features/chat_room/presentation/widgets/message_video_preview/message_video_element.dart';

// Reply Widgets
export 'package:uchat/features/chat_room/presentation/widgets/reply/reply_message_widget.dart';

// Chat Room Widgets
export 'package:uchat/features/chat_room/presentation/widgets/chat_room_app_bar_button.dart';
export 'package:uchat/features/chat_room/presentation/widgets/chat_room_app_bar.dart';
export 'package:uchat/features/chat_room/presentation/widgets/chat_room_message_list.dart';
export 'package:uchat/features/chat_room/presentation/widgets/link_preview_over_input.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_container_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_item_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/message_status_v2.dart';
export 'package:uchat/features/chat_room/presentation/widgets/not_friend_banner.dart';
export 'package:uchat/features/chat_room/presentation/widgets/reply_message_pop_up_widget.dart';
export 'package:uchat/features/chat_room/presentation/widgets/snapping_panel.dart';
export 'package:uchat/features/chat_room/presentation/widgets/swipe_bar.dart';
export 'package:uchat/features/chat_room/presentation/widgets/typing_message.dart';
