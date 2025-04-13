import 'dart:ui' as ui;           // لتسجيل viewFactory على الويب
import 'dart:html' as html;       // لإنشاء IFrame على الويب
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'السيرة الذاتية',
      debugShowCheckedModeBanner: false,
      home: ResumePage(),
    );
  }
}

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  TransformationController _transformationController = TransformationController();
  bool _isZoomed = false;
  final ScrollController _scrollController = ScrollController();

  void _toggleZoom() {
    setState(() {
      if (_isZoomed) {
        _transformationController.value = Matrix4.identity();
      } else {
        _transformationController.value = Matrix4.identity()..scale(2.0);
      }
      _isZoomed = !_isZoomed;
    });
  }

  /// عرض ملف PDF في نافذة منبثقة:
  /// - على الويب: يضمّن IFrame داخل HtmlElementView
  /// - على الأجهزة: يستخدم Syncfusion داخل Dialog
  void _showPdfPopup(String assetPath) {
    if (kIsWeb) {
      final url = Uri.base.resolve(assetPath).toString();
      final viewId = 'pdf-viewer-${url.hashCode}';
      // سجل view factory للـ IFrame
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(viewId, (int _) {
        return html.IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });

      showDialog(
        context: context,
        builder: (_) => Dialog(
          insetPadding: EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: HtmlElementView(viewType: viewId),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          insetPadding: EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SfPdfViewer.asset(assetPath),
          ),
        ),
      );
    }
  }

  // قائمة المسارات
  final List<String> khepra = ['assets/s11.jpg', 'assets/s12.jpg', 'assets/s13.jpg'];
  final List<String> imagesNetwork4 = ['assets/sh1.png', 'assets/sh2.png', 'assets/sh3.png', 'assets/sh4.png'];
  final List<String> imagesNetwork5 = [
    'assets/h4.png','assets/h5.png','assets/h6.png','assets/h7.png',
    'assets/h8.png','assets/h9.png','assets/h10.png','assets/h11.png',
    'assets/h12.png','assets/h13.png','assets/h14.png',
  ];
  final List<String> t3lemy = ['assets/s1.mp4','assets/s2.mp4','assets/s3.mp4','assets/s4.mp4'];
  final List<String> tasmem = [
    'assets/s1.png','assets/ggg1.png','assets/s2.png','assets/s3.png','assets/s4.png',
    'assets/s5.png','assets/s6.png','assets/s7.png','assets/s8.png','assets/s9.png',
    'assets/s10.png','assets/ggg2.png','assets/s12.png',
  ];
  final List<String> apdf = ['assets/p.pdf'];
  final List<String> tpdf = ['assets/t1.pdf','assets/t2.pdf','assets/t3.pdf','assets/t4.pdf'];
  final List<String> imagesNetwork7 = ['assets/ui1.mp4','assets/ui2.png','assets/ui3.png'];
  final List<String> imagesNetwork8 = ['assets/3d.png'];
  final List<String> imagesNetwork9 = ['assets/m1.png','assets/p.pdf','assets/ppp.mp4'];

  List<Map<String, dynamic>> get segments => [
    {'svg': 'assets/b1.svg', 'media': khepra},
    {'svg': 'assets/b2.svg', 'media': imagesNetwork4},
    {'svg': 'assets/b3.svg', 'media': imagesNetwork5},
    {'svg': 'assets/b4.svg', 'media': t3lemy},
    {'svg': 'assets/b5.svg', 'media': tasmem},
    {'svg': 'assets/b6.svg', 'media': apdf},
    {'svg': 'assets/b7.svg', 'media': tpdf},
    {'svg': 'assets/b8.svg', 'media': imagesNetwork7},
    {'svg': 'assets/b9.svg', 'media': imagesNetwork8},
    {'svg': 'assets/b10.svg', 'media': imagesNetwork9},
  ];

  Widget buildMediaGrid(List<String> media) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: media.map((path) {
          final isVideo = path.toLowerCase().endsWith('.mp4');
          final isPdf = path.toLowerCase().endsWith('.pdf');
          return GestureDetector(
            onTap: () {
              if (isPdf) {
                _showPdfPopup(path);
              } else {
                _showFullScreenMedia(path);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      (isVideo || isPdf) ? 'assets/any.png' : path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isVideo) Icon(Icons.play_circle_fill, color: Colors.red, size: 24),
                if (isPdf) Icon(Icons.picture_as_pdf, color: Colors.red, size: 24),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFullScreenMedia(String path) {
    final isVideo = path.toLowerCase().endsWith('.mp4');
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: isVideo
              ? VideoPlayerDialog(videoPath: path)
              : InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            minScale: 1.0,
            maxScale: 10.0,
            child: Image.asset(
              path,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('السيرة الذاتية')),
      body: GestureDetector(
        onDoubleTap: _toggleZoom,
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 1.0,
          maxScale: 4.0,
          child: Scrollbar(
            controller: _scrollController,
            thickness: 10,
            radius: Radius.circular(10),
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => _showFullScreenMedia('assets/any.png'),
                      child: Image.asset(
                        'assets/any.png',
                        width: 280,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ...segments.map((segment) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) => SvgPicture.asset(
                            segment['svg'],
                            width: constraints.maxWidth,
                            fit: BoxFit.contain,
                          ),
                        ),
                        buildMediaGrid(segment['media']),
                        SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// قسم تشغيل الفيديو
class VideoPlayerDialog extends StatefulWidget {
  final String videoPath;
  const VideoPlayerDialog({required this.videoPath});
  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  Duration _currentPosition = Duration.zero;
  Duration _videoDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() => _videoDuration = _controller.value.duration);
        _controller.play();
        _controller.addListener(() => setState(() => _currentPosition = _controller.value.position));
      });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _seekForward() => _controller.seekTo(_controller.value.position + Duration(seconds: 10));
  void _seekBackward() => _controller.seekTo(_controller.value.position - Duration(seconds: 10));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: _controller.value.isInitialized
            ? InteractiveViewer(
          minScale: 1.2,
          maxScale: 10.0,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.red, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slider(
                        value: _currentPosition.inSeconds.toDouble(),
                        max: _videoDuration.inSeconds.toDouble(),
                        onChanged: (v) => _controller.seekTo(Duration(seconds: v.toInt())),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.replay_10, color: Colors.red), onPressed: _seekBackward),
                          IconButton(
                              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.red),
                              onPressed: _togglePlayPause),
                          IconButton(icon: Icon(Icons.forward_10, color: Colors.red), onPressed: _seekForward),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
