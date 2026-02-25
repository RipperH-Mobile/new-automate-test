import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_text_theme.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_info_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_length_map.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_mark_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_text_field.dart';

void main() {
  // Define mock data to be used in tests
  final mockMentions = [
    MentionMarkModel(
      trigger: '@',
      data: [
        MentionInfoModel(id: '1', display: 'john', userName: 'john_doe', nameValue: 'john'),
        MentionInfoModel(id: '2', display: 'jane', userName: 'jane_doe', nameValue: 'jane'),
      ],
      style: const TextStyle(color: Colors.blue),
    ),
    MentionMarkModel(
      trigger: '#',
      data: [
        MentionInfoModel(id: '3', display: 'project', userName: 'project_xyz', nameValue: 'project'),
        MentionInfoModel(id: '4', display: 'task', userName: 'task_abc', nameValue: 'task'),
      ],
      style: const TextStyle(color: Colors.green),
    ),
  ];

  late GlobalKey<MentionTextFieldState> stateKey;
  late bool suggestionsVisibleCallbackValue;

  Future<void> pumpWidget(WidgetTester tester) async {
    stateKey = GlobalKey<MentionTextFieldState>();
    suggestionsVisibleCallbackValue = false;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            // --- FIX: Provide the mocked theme extension ---
            theme: ThemeData(
              extensions: [
                AppColorsTheme.light(),
                AppTextTheme.sfPro(),
              ],
            ),
            home: Portal(
              child: Scaffold(
                body: MentionTextField(
                  key: stateKey,
                  mentions: mockMentions,
                  onSuggestionVisibleChanged: (visible) {
                    suggestionsVisibleCallbackValue = visible;
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper to set text, call listener, and flush timers
  Future<void> setTextAndCursor(
    WidgetTester tester,
    String text,
    int cursorPosition,
  ) async {
    final state = stateKey.currentState!;
    state.textEditingController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
    state.suggestionListener();
    await tester.pumpAndSettle();
  }

  MentionLengthMap? getSelectedMention(MentionTextFieldState state) => state.selectedMention;

  group('MentionTextFieldState.suggestionListener', () {
    testWidgets('should not show suggestions for empty text', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, '', 0);
      expect(state.showSuggestions.value, isFalse);
      expect(suggestionsVisibleCallbackValue, isFalse);
      expect(getSelectedMention(state), isNull);
    });

    testWidgets('should not show suggestions for plain text', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, 'Hello world', 11);
      expect(state.showSuggestions.value, isFalse);
      expect(suggestionsVisibleCallbackValue, isFalse);
      expect(getSelectedMention(state), isNull);
    });

    testWidgets('should show suggestions for trigger only (@ -> select -> @{name})', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, '@', 1); // This already settles
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected = getSelectedMention(state);
      expect(selected, isNotNull);
      expect(selected!.str, '@');
      expect(selected.start, 0);
      expect(selected.end, 1);

      // before selection
      expect(state.currentText, '@');

      // Simulate selecting the first mention
      final mentionItem = mockMentions[0].data[0];
      state.addMention(mentionItem);

      // after selection
      expect(state.currentText, '@${mentionItem.display} ');
    });

    testWidgets('should show suggestions for multiple trigger ex. (@@ -> select -> @ @{name})', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, '@@', 2); // This already settles
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected = getSelectedMention(state);
      expect(selected, isNotNull);
      expect(selected!.str, '@@');
      expect(selected.start, 1);
      expect(selected.end, 2);

      // before selection
      expect(state.currentText, '@@');

      // Simulate selecting the first mention
      final mentionItem = mockMentions[0].data[0];
      state.addMention(mentionItem);

      // after selection
      expect(state.currentText, '@ @${mentionItem.display} ');

      // case 3 triggers
      await setTextAndCursor(tester, '@@@', 3); // This already settles
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected2 = getSelectedMention(state);
      expect(selected2, isNotNull);
      expect(selected2!.str, '@@@');
      expect(selected2.start, 2);
      expect(selected2.end, 3);

      // before selection
      expect(state.currentText, '@@@');

      // Simulate selecting the first mention
      final mentionItem2 = mockMentions[0].data[1];
      state.addMention(mentionItem2);

      // after selection
      expect(state.currentText, '@@ @${mentionItem2.display} ');
    });

    testWidgets('should show suggestions for trigger + text', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, '@jo', 3);
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected = getSelectedMention(state);
      expect(selected, isNotNull);
      expect(selected!.str, '@jo');
      expect(selected.start, 0);
      expect(selected.end, 3);

      // before selection
      expect(state.currentText, '@jo');

      // Simulate selecting the first mention
      final mentionItem = mockMentions[0].data[1];
      state.addMention(mentionItem);

      // after selection
      expect(state.currentText, '@${mentionItem.display} ');
    });

    testWidgets('should show suggestions for text + trigger + text', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, 'Hello @ja', 9);
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected = getSelectedMention(state);
      expect(selected, isNotNull);
      expect(selected!.str, '@ja');
      expect(selected.start, 6);
      expect(selected.end, 9);

      // before selection
      expect(state.currentText, 'Hello @ja');

      // Simulate selecting the first mention
      final mentionItem = mockMentions[0].data[1];
      state.addMention(mentionItem);

      // after selection
      expect(state.currentText, 'Hello @${mentionItem.display} ');
    });

    testWidgets('should show suggestions for text + trigger + text (multiple trigger)', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;
      await setTextAndCursor(tester, 'Hello @@ja', 10);
      expect(state.showSuggestions.value, isTrue);
      expect(suggestionsVisibleCallbackValue, isTrue);
      final selected = getSelectedMention(state);
      expect(selected, isNotNull);
      expect(selected!.str, '@@ja');
      expect(selected.start, 7);
      expect(selected.end, 10);

      // before selection
      expect(state.currentText, 'Hello @@ja');

      // Simulate selecting the first mention
      final mentionItem = mockMentions[0].data[1];
      state.addMention(mentionItem);

      // after selection
      expect(state.currentText, 'Hello @ @${mentionItem.display} ');
    });

    testWidgets('should not trigger if cursor is at -1 (no selection)', (tester) async {
      await pumpWidget(tester);
      final state = stateKey.currentState!;

      state.textEditingController.value = const TextEditingValue(
        text: '@hello',
        selection: TextSelection.collapsed(offset: -1),
      );
      state.suggestionListener();
      await tester.pumpAndSettle();

      expect(state.showSuggestions.value, isFalse);
      expect(suggestionsVisibleCallbackValue, isFalse);
      expect(getSelectedMention(state), isNull);
    });
  });

  group('test addMention', () {
    void testAddMention({
      required String initialText,
      required int cursorPosition,
      MentionInfoModel? mentionToAdd,
      required String expectedTextAfter,
      bool? expectSuggestionVisible,
    }) {
      testWidgets('addMention adds mention correctly to "$initialText"', (tester) async {
        await pumpWidget(tester);
        final state = stateKey.currentState!;
        await setTextAndCursor(tester, initialText, cursorPosition);

        // expect suggestion visibility if provided
        if (expectSuggestionVisible != null) {
          // expect(state.showSuggestions.value, expectSuggestionVisible);
          expect(suggestionsVisibleCallbackValue, expectSuggestionVisible);
        }

        // before selection
        expect(state.currentText, initialText);

        // Simulate selecting the mention
        if (mentionToAdd != null) state.addMention(mentionToAdd);

        // after selection
        expect(state.currentText, expectedTextAfter);
      });
    }

    testAddMention(
      initialText: 'Hello @ja',
      cursorPosition: 9,
      mentionToAdd: mockMentions[0].data[1],
      expectedTextAfter: 'Hello @jane ',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: '@',
      cursorPosition: 1,
      mentionToAdd: mockMentions[0].data[0],
      expectedTextAfter: '@john ',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: '@@@',
      cursorPosition: 3,
      mentionToAdd: mockMentions[0].data[1],
      expectedTextAfter: '@@ @jane ',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: 'Start @@',
      cursorPosition: 8,
      mentionToAdd: mockMentions[0].data[1],
      expectedTextAfter: 'Start @ @jane ',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: 'Multiple @@@ here',
      cursorPosition: 12,
      mentionToAdd: mockMentions[0].data[0],
      expectedTextAfter: 'Multiple @@ @john  here',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: 'No trigger here',
      cursorPosition: 14,
      expectedTextAfter: 'No trigger here',
      expectSuggestionVisible: false,
    );

    testAddMention(
      initialText: 'Edge case @',
      cursorPosition: 11,
      expectedTextAfter: 'Edge case @',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: '',
      cursorPosition: 0,
      expectedTextAfter: '',
      expectSuggestionVisible: false,
    );

    testAddMention(
      initialText: '@hello world2',
      cursorPosition: 6,
      mentionToAdd: mockMentions[0].data[0],
      expectedTextAfter: '@john  world2',
      expectSuggestionVisible: true,
    );

    testAddMention(
      initialText: '@hello world',
      cursorPosition: 8,
      expectedTextAfter: '@hello world',
      expectSuggestionVisible: false,
    );

    testAddMention(
      initialText: 'test@',
      cursorPosition: 5,
      expectedTextAfter: 'test@',
      expectSuggestionVisible: false,
    );

    // case # for trigger
    testAddMention(
      initialText: '#',
      cursorPosition: 1,
      mentionToAdd: mockMentions[1].data[0],
      expectedTextAfter: '#project ',
      expectSuggestionVisible: true,
    );
  });
}
