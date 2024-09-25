// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/app_colors.dart';

class VideoPlayerForSelectedViedeo extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerForSelectedViedeo({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerForSelectedViedeo> createState() =>
      _VideoPlayerForSelectedViedeoState();
}

class _VideoPlayerForSelectedViedeoState
    extends State<VideoPlayerForSelectedViedeo> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializedVideoPlayerFuture;
  bool _isMuted = true;
  bool _isPaused = false;

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;

      if (_isPaused) {
        _videoPlayerController.play();
      } else {
        _videoPlayerController.pause();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializedVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(true);
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializedVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Stack(fit: StackFit.expand, children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            _toggleMute();
                          },
                        ),
                      ),
                      AppConstant.customSizedBox(0, 20),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            !_isPaused ? Icons.play_arrow : Icons.pause,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: _togglePause,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
        });
  }
}
