import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Video_page extends StatefulWidget {
  final String name;
  final String media_url;

  Video_page(this.name, this.media_url);

  @override
  State<Video_page> createState() => _Video_pageState();
}

class _Video_pageState extends State<Video_page> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    //TODO: implement initstate
    super.initState();
    initVideoController();
  }

  initVideoController() async {
    videoPlayerController = VideoPlayerController.asset("${widget.media_url}");
    videoPlayerController.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        autoPlay: true,
        looping: true,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        title: Text(
          "Video Player",
          style: GoogleFonts.shortStack(color: CupertinoColors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 570,
                  width: 320,
                  child: videoPlayerController.value.isInitialized
                      ? SizedBox(
                    height: 500,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
  }
}