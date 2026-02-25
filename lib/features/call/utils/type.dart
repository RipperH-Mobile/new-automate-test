import 'package:flutter/material.dart';
import 'package:uchat/features/call/utils/enum.dart';

typedef CallUiStateWidgetBuilder = Widget Function(BuildContext context, UiCallState uiState);
typedef StringWidgetBuilder = Widget Function(BuildContext context, String txt);
typedef CallUiStatePreferredSizeWidgetBuilder = PreferredSizeWidget Function(BuildContext context, UiCallState uiState);
