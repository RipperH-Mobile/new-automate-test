//------------------------------------Arguments for Authentication feature------------------------------------------------------------------------
export 'package:uchat/features/auth/presentation/arguments/create_account_confirm_password_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/create_account_name_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/create_account_profile_avatar_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/create_account_set_password_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/create_account_uchat_id_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/forgot_password_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/forgot_password_get_otp_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/link_account_with_apple_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/link_account_with_email_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/link_account_with_facebook_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/link_account_with_google_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/login_password_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/login_with_phone_number_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/verify_otp_forgot_password_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/verify_otp_link_email_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/verify_otp_login_arguments.dart';
export 'package:uchat/features/auth/presentation/arguments/verify_otp_register_arguments.dart';

//------------------------------------Bindings for the Authentication feature------------------------------------------------------------------------
export 'package:uchat/features/auth/presentation/bindings/create_account_confirm_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/create_account_name_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/create_account_profile_avatar_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/create_account_set_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/create_account_uchat_id_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/forgot_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/forgot_password_get_otp_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/link_account_with_apple_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/link_account_with_email_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/link_account_with_facebook_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/link_account_with_google_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/login_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/login_welcome_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/login_with_email_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/login_with_phone_number_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/logout_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/setup_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/verify_otp_forgot_password_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/verify_otp_link_email_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/verify_otp_login_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/verify_otp_register_binding.dart';
export 'package:uchat/features/auth/presentation/bindings/welcome_binding.dart';

//------------------------------------Controllers for the Authentication feature------------------------------------------------------------------------

// Forgot Password Controllers
export 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_get_otp_controller.dart';

// Link Account Controllers
export 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_apple_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_email_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_facebook_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_google_controller.dart';

// Login Controllers
export 'package:uchat/features/auth/presentation/controllers/login/login_password_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/login/login_with_email_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/login/login_with_phone_number_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/login/oa_login_controller.dart';

// Login Welcome Controllers
export 'package:uchat/features/auth/presentation/controllers/login_welcome/login_welcome_controller.dart';

// Logout Controllers
export 'package:uchat/features/auth/presentation/controllers/logout/logout_controller.dart';

// Registration Controllers
export 'package:uchat/features/auth/presentation/controllers/register/create_account_confirm_password_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/register/create_account_name_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/register/create_account_profile_avatar_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/register/create_account_set_password_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/register/create_account_uchat_id_controller.dart';

// Setup Password Controllers
export 'package:uchat/features/auth/presentation/controllers/set_up_password/setup_password_controller.dart';

// Verify OTP Controllers
export 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_forgot_password_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_link_email_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_login_controller.dart';
export 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_register_controller.dart';

// Welcome Controllers
export 'package:uchat/features/auth/presentation/controllers/welcome/welcome_controller.dart';

//------------------------------------Screens for the Authentication feature------------------------------------------------------------------------

// Forgot Password Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_confirm_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_get_otp_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_setup_new_password_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/forgot_password/forgot_password_setup_success_screen.dart';

// Link Account Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_apple_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_email_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_with_google_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/link_account/link_account_wth_facebook_screen.dart';

// Login Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/login/login_password_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/login/login_with_email_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/login/login_with_phone_number_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/login/oa_login_screen.dart';

// Login Welcome Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/login_welcome/login_welcome_screen.dart';

// Logout Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/logout/logout_screen.dart';

// Registration Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_confirm_password_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_name_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_profile_avatar_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_screen_layout.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_set_password_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_uchat_id_screen.dart';

// Setup Password Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/set_up_password/setup_password_confirm_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/set_up_password/setup_password_create_screen.dart';

// Verify OTP Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_forgot_password_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_link_email_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_login_screen.dart';
export 'package:uchat/features/auth/presentation/views/screens/mobile/verify/verify_otp_register_screen.dart';

// Welcome Screens
export 'package:uchat/features/auth/presentation/views/screens/mobile/welcome/welcome_screen.dart';

//------------------------------------Widgets for the Authentication feature------------------------------------------------------------------------
export 'package:uchat/features/auth/presentation/views/widgets/button.dart';
export 'package:uchat/features/auth/presentation/views/widgets/enabled_counties_bottom_sheet_screen.dart';
export 'package:uchat/features/auth/presentation/views/widgets/link_account_widget.dart';
export 'package:uchat/features/auth/presentation/views/widgets/login_with_phone_number_input.dart';
export 'package:uchat/features/auth/presentation/views/widgets/password_condition_check_list.dart';
export 'package:uchat/features/auth/presentation/views/widgets/qr_login_bottom_sheet_impl.dart';
export 'package:uchat/features/auth/presentation/views/widgets/qr_login_bottom_sheet.dart';
export 'package:uchat/features/auth/presentation/views/widgets/started_bottom_sheet.dart';
export 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';
