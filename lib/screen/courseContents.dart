import 'package:flutter/material.dart';
import 'package:seeker/models/courseContentModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseContents extends StatelessWidget {
  static const routeName = '/courseContents';
  @override
  Widget build(BuildContext context) {
    final contents =
        ModalRoute.of(context).settings.arguments as CourseContentModel;
    // Youtube Player Controller
    // Youtube Player Controller
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: contents.contentVideoUrl,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    // Return of Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(contents.contentTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video

            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.red,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.yellow,
              ),
              // onReady: () {
              //     _controller.addListener(listener);
              // },
            ),
            // Container(
            //   height: 240,
            //   color: Colors.grey,
            //   width: double.infinity,
            //   child: Center(
            //     child: Text("Youtube Video"),
            //   ),
            // ),
            // Title of the Content
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Text(
                "Title of the Content",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Content Descripto
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                """Hey folks, nowadays, Flutter is the fastest growing technology as well as skills amongst software engineers. So, today I will show you how to display YouTube videos in your Flutter application.""",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Image
            Container(
              height: 220,
              width: double.infinity,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ6HjXpNIt5wMhlmyUedtsojU2NaunF-CkMQ&usqp=CAU',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                """
First of all, add the youtube_player_flutter plugin to your pubspecp.yaml file. Please check the latest version by clicking on the attached link. This plugin supports both Android and iOS platforms. No need to add an API key to a google account.\n
First of all, add the YoutubePlayer widget to display video in your Flutter application.
showVideoProgressIndicator - to true to display a progress bar at the time of buffering.
initialVideoId - add YouTube ID to display video. The plugin also provides a method to extract the video-id from the URL. code snippet available below.
progressIndicatorColor - set progress bar color as per matching with app’s theme.
controller - used to display custom controllers and also provide methods to add controls.
hideControls - To hide the controls when playing the videos. The default value is false which means by default controls will be displayed on the screen. If set to true controls will not be visible.
controlsVisibleAtStart - If set to true controls will be visible at the start of the video. The default value is false.
Now, how to extract video ID from the whole YouTube URL? YoutubePlayer.convertUrlToId() method will return YouTube video ID from the given URL.

                  """,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.red[100],
        child: Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: 35,
        ),
        onPressed: () {},
      ),
    );
  }
}
