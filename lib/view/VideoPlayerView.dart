import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {

  final String videoUrl;

  VideoPlayerView(this.videoUrl);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {

  VideoPlayerController videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoController = VideoPlayerController
        .network(widget.videoUrl)
        ..initialize().then((stuff){
            setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child:
        videoController.value.initialized ? Stack(
          fit: StackFit.expand,
          children: <Widget>[
            VideoPlayer(videoController),
//            AspectRatio(
////              aspectRatio: 300,
////              child:
////            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: IconButton(
                    icon: Icon(videoController.value.isPlaying ? LineAwesomeIcons.pause : LineAwesomeIcons.pause, color: Colors.white,),
                    onPressed: (){
                      if(videoController.value.isPlaying){
                        setState(() {
                          videoController.pause();
                        });
                      }else{
                        setState(() {
                          videoController.play();
                        });
                      }
                    }),
              ),
            )
          ],

        ) :
        videoController.value.hasError ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Sorry. An error occured", style: Theme.of(context).textTheme.display1,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    videoController.initialize();
                  });
                },
                child: Text("Reload", style: Theme.of(context).textTheme.title.copyWith(color: Colors.orange, fontSize: 25),)
              ),
            ],
          ),

        )

        : Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
