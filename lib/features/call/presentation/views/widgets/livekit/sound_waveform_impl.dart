/*
 * Copyright 2024 LiveKit, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * [SoundWaveformWidget] Originally adapted from: https://github.com/SushanShakya/sound_waveform
 *
 * MIT License
 *
 * Copyright (c) 2022 Sushan Shakya
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/sound_waveform.dart';
import 'package:uchat/widgets/animation/circle_ripper/ripper_animation.dart';

class SoundWaveFormLocalImpl<C extends UChatLiveKitController> extends GetView<C> {
  final String roomId;

  const SoundWaveFormLocalImpl({super.key, required this.roomId});

  @override
  String? get tag => roomId;

  LocalAudioTrack? get localAudioTrack => controller.room?.localParticipant?.audioTrackPublications.firstOrNull?.track;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (localAudioTrack == null) {
          return const SizedBox.shrink();
        }
        return SoundWaveformWidget(
          audioTrack: localAudioTrack!,
          count: 10,
          minHeight: 20,
          maxHeight: 100,
          width: 10,
          durationInMilliseconds: 1000,
        );
      },
    );
  }
}

class SoundWaveFormRemoteImpl<C extends UChatLiveKitController> extends GetView<C> {
  final String roomId;

  const SoundWaveFormRemoteImpl({super.key, required this.roomId});

  @override
  String? get tag => roomId;

  RemoteAudioTrack? get remoteAudioTrack =>
      controller.remoteParticipants.firstOrNull?.audioTrackPublications.firstOrNull?.track;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (remoteAudioTrack == null) {
          return const SizedBox.shrink();
        }
        return SoundWaveformWidget(
          audioTrack: remoteAudioTrack!,
          count: 10,
          minHeight: 100,
          maxHeight: 100,
          width: 10,
          durationInMilliseconds: 1000,
        );
      },
    );
  }
}

class SoundWaveFormRingingImpl extends StatelessWidget {
  final double size;
  final Widget avatar;
  final bool doAnimate;
  final bool speaking;
  final Color waveColor;

  const SoundWaveFormRingingImpl({
    super.key,
    required this.size,
    required this.avatar,
    this.doAnimate = false,
    this.speaking = false,
    this.waveColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RipplesAnimation(
        isDisableSignalAnimation: true,
        size: (size / 2) + AppSpace.space12,
        color: waveColor,
        waveLoop: doAnimate,
        screenWidth: constraints.maxWidth,
        builder: (animation) {
          if (animation != null && speaking == true && !animation.isAnimating) {
            if (animation.isCompleted) {
              animation.reset();
              animation.forward();
            } else {
              animation.forward();
            }
          }
          return avatar;
        },
      );
    });
  }
}
