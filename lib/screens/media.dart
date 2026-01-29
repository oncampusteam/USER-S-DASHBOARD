import 'package:flutter/material.dart';
import 'package:on_campus/classes/constants.dart';
// import 'package:on_campus/widgets/video.dart';
// import 'package:video_player/video_player.dart';

class MediaScreen extends StatefulWidget {
  // final String title;
  final String type;
  final List<String> media;
  const MediaScreen({
    super.key,
    // required this.title,
    required this.media,
    this.type = "photos",
  });

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   // 1. Initialize the controller
  //   if(widget.type == "videos" && widget.videos.isNotEmpty){
  //     _controller = VideoPlayerController.networkUrl(
  //     Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
  //   )..initialize().then((_) {
  //       // 2. Set properties for "Preview" mode
  //       _controller.setVolume(0); // Muted for preview
  //       _controller.setLooping(true); // Loop the preview
  //       _controller.play(); // Start playing automatically
  //       setState(() {}); // Refresh to show the first frame
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xFF0B1218), // Consistent suite background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [Icon(Icons.close, color: Color(0xFF323232), size: 20)],
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
        //   onPressed: () => Navigator.pop(context),
        // ),
        centerTitle: false,
        title: SizedBox(
          width: 80,
          height: 24,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.type == "photos" ? "Photos" : "Videos",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(
                  0xFF323232,
                ), // Applied as requested, though dark theme might need contrast adjustment
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                if (widget.type == "photos") _buildImageGallery(),
                if (widget.type == "videos")
                  // VideoGalleryList(videoUrls: widget.media),
                const SizedBox(height: 70), // Padding for floating button
              ],
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    // List of images from your reference
    final List<String> images = widget.media;

    return Column(
      children: images
          .map(
            (url) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ), // 20px borderRadius applied
                child: Image.network(
                  url,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBottomAction() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100,
                    height: 16,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Price Estimate',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12, // Explicitly 12px
                          // color: Colors.white54,
                          color: Color(0xFF00EFD1),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 24,
                        child: FittedBox(
                          child: const Text(
                            'GHS 200',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xFF323232), // Applied as requested
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 18,
                        child: FittedBox(
                          child: const Text(
                            '/Academic year',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Color(0xFF787878),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: Constant.width * 0.3,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF00EFD1), // Requested color
                borderRadius: BorderRadius.circular(
                  12,
                ), // Requested borderRadius
              ),
              child: Center(
                child: SizedBox(
                  width: 120,
                  height: 20,
                  child: FittedBox(
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
