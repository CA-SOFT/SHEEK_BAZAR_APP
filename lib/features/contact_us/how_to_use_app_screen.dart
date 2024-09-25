// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/player/youtube_player.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/utils/youtube_player_controller.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/utils/youtube_player_flags.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/widgets/duration_widgets.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/widgets/playback_speed_button.dart';
import 'package:sheek_bazar/core/extentions/youtube_video_player/src/widgets/progress_bar.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_state.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:flutter_youtube_player/flutter_youtube_player.dart';

class HowToUseAppScreen extends StatefulWidget {
  const HowToUseAppScreen({super.key});

  @override
  State<HowToUseAppScreen> createState() => _HowToUseAppScreenState();
}

class _HowToUseAppScreenState extends State<HowToUseAppScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getTutorialVideos(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "how_to_use".tr(context),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          [],
          true),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.loadingtutorialVideos!
                ? SizedBox(
                    height: 0.8.sh,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : state.tutorialVideos == null
                    ? SizedBox(
                        height: 1.sh,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/empty_data.png"),
                              Text(
                                "There are no videos".tr(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : state.tutorialVideos!.isEmpty
                        ? SizedBox(
                            height: 1.sh,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/empty_data.png"),
                                  Text(
                                    "There are no videos".tr(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: state.tutorialVideos!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BlocBuilder<ThemesCubit, ThemesState>(
                                  builder: (context, theme) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: theme.mode == "dark"
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            offset: const Offset(4.0, 4.0),
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.tutorialVideos![index]
                                                .description!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          YouTubePlayer(
                                              url: state.tutorialVideos![index]
                                                  .link!),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ));
          },
        ),
      ),
    );
  }
}
// Container(
//                                 padding: const EdgeInsets.all(10),
//                                 margin: const EdgeInsets.only(bottom: 15),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.3),
//                                       offset: const Offset(4.0, 4.0),
//                                       blurRadius: 10.0,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           state.tutorialVideos![index]
//                                               .description!,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     AppConstant.customSizedBox(0, 10),
//                                     VideoPlayerWidget(
//                                         videoUrl:
//                                             state.tutorialVideos![index].link!)
//                                   ],
//                                 ))

class YouTubePlayer extends StatefulWidget {
  String url;
  YouTubePlayer({super.key, required this.url});

  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        // disableDragSeek: false,
        // loop: false,
        // isLive: false,
        forceHD: false,
        // enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        const PlaybackSpeedButton()
      ],
    );
  }
}
