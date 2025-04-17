import 'dart:html' as html; // لإنشاء IFrame على الويب وللتنزيل ولإرسال التعليقات
import 'dart:ui_web' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart'; // لإضافة أيقونات لوتي
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:url_launcher/url_launcher.dart'; // لإطلاق الروابط

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'السيرة الذاتية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: ResumePage(),
    );
  }
}

class ResumePage extends StatefulWidget {
  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _ctrlPressed = false;
  bool _dialogOpen = false;
  bool _isDownloadHovered = false;
  bool _isDownloadClicked = false;

  // أرقام التواصل
  static const String _whatsappNumber = '2001065606206';
  static const String _telegramUsername = 'DAROWSHA';

  // ملف الـ PDF
  static const String _cvAsset = 'assets/cv_mostafa_said.pdf';
  static const String _fileName = 'cv_mostafa_said.pdf';

  // Google Apps Script للتعليقات والرسائل
  static const String _commentsScriptUrl =
      'https://script.google.com/macros/s/AKfycbyQ8zY_shhZ7rTHJm8kxLUVsGV9aPJUE9dWgG0_CKt_ratDwt71GBalHi9Y4DxyE8IvPQ/exec';
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _directMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    _commentController.dispose();
    _directMessageController.dispose();
    super.dispose();
  }

  void _handleKey(RawKeyEvent event) {
    final isCtrl = event.isControlPressed;
    if (_ctrlPressed != isCtrl) {
      setState(() {
        _ctrlPressed = isCtrl;
      });
    }
  }

  /// إظهار مربع حوار التعليقات
  Future<void> _showCommentDialog() async {
    _commentController.clear();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('أرسل تعليقاً'),
        content: TextField(
          controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'اكتب تعليقك هنا...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            child: const Text('إرسال'),
            onPressed: () {
              final text = _commentController.text.trim();
              if (text.isNotEmpty) _sendComment(text);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  /// إظهار مربع حوار “إرسال رسالة مباشرة”
  Future<void> _showDirectMessageDialog() async {
    _directMessageController.clear();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إرسال رسالة مباشرة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'برجاء إرسال رسالة بها معلومات أستطيع التواصل معكم من خلالها\n\nشكراً لحضراتكم',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _directMessageController,
              decoration: const InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            child: const Text('إرسال'),
            onPressed: () {
              final msg = _directMessageController.text.trim();
              if (msg.isNotEmpty) _sendComment(msg);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  /// إرسال التعليق أو الرسالة إلى Google Apps Script
  void _sendComment(String text) {
    final encoded = Uri.encodeQueryComponent(text);
    final uri = '$_commentsScriptUrl?comment=$encoded';
    html.HttpRequest.request(uri, method: 'GET').then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم إرسال رسالتك')));
    }).catchError((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('فشل في إرسال الرسالة')));
    });
  }

  /// فتح PDF في نافذة منبثقة
  void _showPdfPopup(String assetPath) {
    if (kIsWeb) {
      final url = Uri.base.resolve(assetPath).toString();
      final viewId = 'pdf-viewer-${url.hashCode}';
      ui.platformViewRegistry.registerViewFactory(viewId, (_) {
        return html.IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
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
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SfPdfViewer.asset(assetPath),
          ),
        ),
      );
    }
  }

  /// تنزيل أو عرض PDF
  void _downloadPdf() {
    if (kIsWeb) {
      final url = Uri.base.resolve(_cvAsset).toString();
      html.AnchorElement(href: url)
        ..setAttribute('download', _fileName)
        ..click();
    } else {
      _showPdfPopup(_cvAsset);
    }
  }

  Future<void> _confirmBeforeDownload() async {
    setState(() {
      _isDownloadClicked = true;
      _dialogOpen = true;
    });
    final screen = MediaQuery.of(context).size;
    final dialogW = screen.width * 0.5;
    final dialogH = screen.height * 0.8;
    if (kIsWeb) {
      final url = Uri.base.resolve(_cvAsset).toString();
      final viewId = 'preview-${url.hashCode}';
      ui.platformViewRegistry.registerViewFactory(viewId, (_) {
        return html.IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });
      await showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: dialogW,
            height: dialogH,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded,
                        size: 36,
                        color: (_isDownloadHovered || _isDownloadClicked)
                            ? Colors.red
                            : Colors.lightBlueAccent),
                    const SizedBox(width: 8),
                    Text(_fileName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: HtmlElementView(viewType: viewId)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        child: const Text('إلغاء'),
                        onPressed: () => Navigator.of(ctx).pop()),
                    ElevatedButton(
                        child: const Text('تحميل'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _downloadPdf();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      final bytes = await rootBundle.load(_cvAsset);
      final sizeKB = (bytes.lengthInBytes / 1024).toStringAsFixed(1);
      await showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: dialogW,
            height: dialogH,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded,
                        size: 36,
                        color: (_isDownloadHovered || _isDownloadClicked)
                            ? Colors.red
                            : Colors.lightBlueAccent),
                    const SizedBox(width: 8),
                    Text(_fileName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('الحجم التقريبي: $sizeKB كيلوبايت'),
                const SizedBox(height: 12),
                Expanded(child: SfPdfViewer.asset(_cvAsset)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        child: const Text('إلغاء'),
                        onPressed: () => Navigator.of(ctx).pop()),
                    ElevatedButton(
                        child: const Text('عرض'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _showPdfPopup(_cvAsset);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    setState(() {
      _dialogOpen = false;
    });
  }

  Future<void> _launchWhatsApp() async {
    final url = 'https://wa.me/$_whatsappNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('لا يمكن فتح WhatsApp')));
    }
  }

  Future<void> _launchTelegram() async {
    final url = 'https://t.me/$_telegramUsername';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('لا يمكن فتح Telegram')));
    }
  }

  // قوائم الوسائط كما في السابق
  final List<String> khepra = ['assets/s11.jpg', 'assets/s12.jpg', 'assets/s13.jpg'];
  final List<String> imagesNetwork4 = [
    'assets/sh1.png',
    'assets/sh2.png',
    'assets/sh3.png',
    'assets/sh4.png'
  ];
  final List<String> imagesNetwork5 = [
    'assets/h4.png',
    'assets/h5.png',
    'assets/h6.png',
    'assets/h7.png',
    'assets/h8.png',
    'assets/h9.png',
    'assets/h10.png',
    'assets/h11.png',
    'assets/h12.png',
    'assets/h13.png',
    'assets/h14.png',
  ];
  final List<String> t3lemy = ['assets/s1.mp4', 'assets/s2.mp4', 'assets/s3.mp4', 'assets/s4.mp4'];
  final List<String> tasmem = [
    'assets/s1.png',
    'assets/ggg1.png',
    'assets/s2.png',
    'assets/s3.png',
    'assets/s4.png',
    'assets/s5.png',
    'assets/s6.png',
    'assets/s7.png',
    'assets/s8.png',
    'assets/s9.png',
    'assets/s10.png',
    'assets/ggg2.png',
    'assets/1x.pdf',
  ];
  final List<String> apdf = ['assets/p.pdf'];
  final List<String> tpdf = ['assets/t1.pdf', 'assets/t2.pdf', 'assets/t3.pdf', 'assets/t4.pdf'];
  final List<String> imagesNetwork7 = ['assets/ui1.mp4', 'assets/ui2.png', 'assets/ui3.png'];
  final List<String> imagesNetwork8 = ['assets/3d.png'];
  final List<String> imagesNetwork9 = ['assets/m1.png', 'assets/p.pdf', 'assets/ppp.mp4'];

  List<Map<String, dynamic>> get segments => [
    {'svg': 'assets/b1.svg', 'media': khepra},
    {'svg': 'assets/b2.svg', 'media': imagesNetwork4},
    {'svg': 'assets/b3.svg', 'media': imagesNetwork9},
    {'svg': 'assets/b4.svg', 'media': imagesNetwork5},
    {'svg': 'assets/b5.svg', 'media': apdf},
    {'svg': 'assets/b6.svg', 'media': tasmem},
    {'svg': 'assets/b7.svg', 'media': t3lemy},
    {'svg': 'assets/b8.svg', 'media': tpdf},
    {'svg': 'assets/b9.svg', 'media': imagesNetwork7},
    {'svg': 'assets/b10.svg', 'media': imagesNetwork8},
    {'svg': 'assets/b11.svg', 'media': []},
  ];

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKey,
      autofocus: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
          title: MouseRegion(
            onEnter: (_) => setState(() => _isDownloadHovered = true),
            onExit: (_) => setState(() => _isDownloadHovered = false),
            child: GestureDetector(
              onTap: _confirmBeforeDownload,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download_rounded,
                    size: 32,
                    color: (_isDownloadHovered || _isDownloadClicked) ? Colors.red : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text('تحميل السيرة الذاتية $_fileName',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        body: InteractiveViewer(
          panEnabled: true,
          scaleEnabled: !_dialogOpen && _ctrlPressed,
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 1.0,
          maxScale: 4.0,
          child: RawScrollbar(
            controller: _scrollController,
            thumbColor: Colors.red,
            thickness: 16.0,
            radius: const Radius.circular(8),
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // صف الأيقونات والمستطيل الجديد (متجاوب)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isNarrow = constraints.maxWidth < 600;
                        return Flex(
                          direction: isNarrow ? Axis.vertical : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // عمود تيليجرام وواتساب
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'اضغط لإرسال رسالة',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: _launchTelegram,
                                  child: Lottie.asset(
                                    'assets/telegram.json',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 0.5),
                                Transform.translate(
                                  offset: const Offset(0, -8),
                                  child: GestureDetector(
                                    onTap: _launchWhatsApp,
                                    child: Lottie.asset(
                                      'assets/whats.json',
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // فاصل
                            isNarrow
                                ? const SizedBox(height: 12)
                                : const SizedBox(width: 12),
                            // الصورة
                            GestureDetector(
                              onTap: () => _showFullScreenMedia('assets/any.png'),
                              child: Image.asset(
                                'assets/any.png',
                                width: isNarrow ? constraints.maxWidth * 0.8 : 280,
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // فاصل
                            isNarrow
                                ? const SizedBox(height: 8)
                                : const SizedBox(width: 8),
                            // مستطيل إرسال رسالة مباشرة
                            GestureDetector(
                              onTap: _showDirectMessageDialog,
                              child: Container(
                                width: isNarrow ? constraints.maxWidth * 0.8 : null,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  ' إرسال رسالة مباشرة سرية\nلا تحتاج لأي تسجيلات دخول او انتقلات ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  // باقي الأقسام SVG والوسائط
                  ...segments.map((segment) {
                    final media = (segment['media'] as List).cast<String>();
                    final svgPath = segment['svg'] as String;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;
                        return Column(
                          children: [
                            SvgPicture.asset(svgPath, width: screenWidth, fit: BoxFit.fitWidth),
                            const SizedBox(height: 8),
                            buildMediaGrid(media, screenWidth),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
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

  // شبكة عرض الوسائط (صور، فيديو، PDF)
  Widget buildMediaGrid(List<String> media, double gridWidth) {
    return Container(
      width: gridWidth,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: media.map((path) {
          final isVideo = path.toLowerCase().endsWith('.mp4');
          final isPdf = path.toLowerCase().endsWith('.pdf');
          double itemSize = (gridWidth * 0.3).clamp(0, 150);
          return GestureDetector(
            onTap: () {
              if (isPdf)
                _showPdfPopup(path);
              else
                _showFullScreenMedia(path);
            },
            child: ShapeOfView(
              elevation: 4,
              shape: BubbleShape(
                position: BubblePosition.Bottom,
                arrowPositionPercent: 0.5,
                borderRadius: 16,
              ),
              child: Container(
                width: itemSize,
                height: itemSize,
                color: Colors.grey.shade100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      (isVideo || isPdf) ? 'assets/any.png' : path,
                      fit: BoxFit.contain,
                    ),
                    if (isVideo)
                      const Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
                    if (isPdf)
                      const Icon(Icons.picture_as_pdf, color: Colors.white, size: 32),
                  ],
                ),
              ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: isVideo
                ? VideoPlayerDialog(videoPath: path)
                : Image.asset(path, fit: BoxFit.contain, width: MediaQuery.of(context).size.width),
          ),
        ),
      ),
    );
  }
}

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
        _controller.addListener(
                () => setState(() => _currentPosition = _controller.value.position));
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

  void _seekForward() =>
      _controller.seekTo(_controller.value.position + const Duration(seconds: 10));
  void _seekBackward() =>
      _controller.seekTo(_controller.value.position - const Duration(seconds: 10));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_controller),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 30),
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
                    onChanged: (v) =>
                        _controller.seekTo(Duration(seconds: v.toInt())),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.replay_10, color: Colors.red),
                          onPressed: _seekBackward),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.red),
                        onPressed: _togglePlayPause,
                      ),
                      IconButton(
                          icon: const Icon(Icons.forward_10, color: Colors.red),
                          onPressed: _seekForward),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : const CircularProgressIndicator(),
    );
  }
}
