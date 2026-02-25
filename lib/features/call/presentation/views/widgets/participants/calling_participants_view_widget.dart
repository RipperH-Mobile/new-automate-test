import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/group.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/animation/transition/bottom_transition.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class CallingParticipantsViewWidget extends StatelessWidget {
  CallingParticipantsViewWidget({super.key, required this.participants});

  //NOTE.Mock model will change it later
  final List<MockCallModel> participants;

  final currentUser = Get.find<UserController>().currentUser();

  @override
  Widget build(BuildContext context) {
    final localUserUrl = currentUser?.avatarUrl ?? '';
    // List<String> participantUrl = controller.remoteParticipants.map(
    //   (element) {
    //     String? participant = element.identity;
    //     final memberData = controller.getMember(participant);
    //     return memberData?.avatarUrl ?? '';
    //   },
    // ).toList();
    List<String> participantUrl = participants.map(
      (element) {
        return element.imageUrl ?? '';
      },
    ).toList();
    participantUrl.add(localUserUrl);
    const limitNumber = 4;
    int totalRange = participantUrl.length;
    if (participantUrl.length > limitNumber) {
      totalRange = limitNumber;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: fromBottomTransitionBuilder,
      child: GestureDetector(
        onTap: () => _showParticipantBottomSheet(context),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: 55.spMin,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '@number participants'.trParams(
                  {'number': '${participants.length + 1}'},
                ),
                style: const TextStyle(color: Color(0xff0E5CAA), fontWeight: FontWeight.w600),
              ),
              Stack(
                children: [
                  ...[
                    // Participant image profile list
                    ...List<Widget>.generate(
                      totalRange,
                      (index) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 8.0 + (20 * (totalRange)) - (20 * index),
                          ),
                          child: Avatar(
                            image: UChatImage.networkProvider(
                              participantUrl[index],
                            ),
                            radius: 20,
                            backgroundColor: Colors.white,
                            borderColor: Colors.transparent,
                            borderWidth: 3.0,
                          ),
                        ),
                      ),
                    ),
                    ...[
                      // Over limit participant number (more +)
                      if (participantUrl.length > limitNumber)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '+${participantUrl.length - limitNumber}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ]
                  ],
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showParticipantBottomSheet(BuildContext context) {
    List<Map<String, String>> participantMap = participants.map(
      (element) {
        return {
          'name': element.title ?? '',
          'avatar': element.imageUrl ?? '',
        };
      },
    ).toList();
    participantMap.add({
      'name': currentUser?.displayName ?? '',
      'avatar': currentUser?.avatarUrl ?? '',
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.80,
              snap: true,
              builder: (_, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.grey[600],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Text(
                            'Participants'.tr,
                            style: const TextStyle(
                              color: Color(0xff0E5CAA),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: participantMap.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                    color: Colors.black87,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Avatar(
                                        image: UChatImage.networkProvider(
                                          participantMap[index]['avatar'] ?? '',
                                        ),
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        borderColor: Colors.transparent,
                                        borderWidth: 3.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          participantMap[index]['name'] ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
