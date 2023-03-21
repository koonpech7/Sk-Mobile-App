import 'package:flutter/material.dart';
import 'package:testflutter/components/appbar.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CameraScreens extends StatefulWidget {
  const CameraScreens({super.key});

  @override
  State<CameraScreens> createState() => _CameraScreensState();
}

class _CameraScreensState extends State<CameraScreens> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  // final VlcPlayerController _playerController - VlcPlayerController.net

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'http://202.44.35.76:9093/stream/27aec28e-6181-4753-9acd-0456a75f0289/channel/0/hls/live/index.m3u8');
    await Future.wait([videoPlayerController.initialize()]);

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        additionalOptions: (context) {
          return <OptionItem>[
            OptionItem(
              onTap: () => debugPrint('OPtion 1'),
              iconData: Icons.chat,
              title: 'Option1',
            ),
            OptionItem(
              onTap: () => debugPrint("OPtion 2"),
              iconData: Icons.share,
              title: 'Option2',
            )
          ];
        });
    setState(() {});
  }

  // void _initPlayer() async {
  //   videoPlayerController = VideoPlayerController.network(
  //       'https://32aa-202-44-35-79.ap.ngrok.io/stream/aefc49f7-e29b-4a84-bd42-7ba08e51f16d/channel/0/hls/live/index.m3u8');
  //   await Future.wait([videoPlayerController.initialize()]);

  //   chewieController = ChewieController(
  //       videoPlayerController: videoPlayerController,
  //       autoPlay: true,
  //       additionalOptions: (context) {
  //         return <OptionItem>[
  //           OptionItem(
  //             onTap: () => debugPrint('OPtion 1'),
  //             iconData: Icons.chat,
  //             title: 'Option1',
  //           ),
  //           OptionItem(
  //             onTap: () => debugPrint("OPtion 2"),
  //             iconData: Icons.share,
  //             title: 'Option2',
  //           )
  //         ];
  //       });
  //   setState(() {});
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    // videoPlayerController.dispose();
    // chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF1F1F39),
        appBar: SKAppBar(
          title: "Camara Room 702",
          subtitle: "Camara 702",
          onPressed: () {
            Navigator.pop(context);
          },
          havetactions: false,
        ),
        body: chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: chewieController!)
            : const Center(
                child: CircularProgressIndicator(),
              )

        // body: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Column(children: [
        //     Container(
        //       height: height / 1.5,
        //       width: width,
        //       padding: const EdgeInsets.all(8),
        //       color: Colors.green,
        //       child: Column(
        //         children: [
        //           Container(
        //             height: height / 2,
        //             width: width,
        //             color: Colors.red,
        //           ),
        //           const SizedBox(
        //             height: 10,
        //             width: 10,
        //           ),
        //           Container(
        //             height: height / 8,
        //             width: width,
        //             color: Colors.blue,
        //           )
        //         ],
        //       ),
        //     )
        //   ]),
        // ),
        );
  }
}
