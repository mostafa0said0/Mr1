import 'dart:convert';
import 'dart:html' as html; // لإنشاء IFrame على الويب وللتنزيل ولإرسال التعليقات
import 'dart:ui_web' as ui;
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

enum LanguageMode { arabic, both, english }
enum ScreenCategory { small, large }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'السيرة الذاتية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white54,
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
  LanguageMode _language = LanguageMode.both;
  ScreenCategory? _screenCategory;

  // للتحكم في التكبير/التصغير برمجياً
  final TransformationController _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

  final List<List<String>> _mediaLists = [
    ['assets/s11.jpg', 'assets/s12.jpg', 'assets/sm.png', 'assets/s13.jpg','assets/e.png'],
    ['assets/sh1.png', 'assets/sh2.png', 'assets/sh3.png', 'assets/sh4.png', 'assets/m1.pdf'],
    ['assets/m1.png', 'assets/m1.pdf', 'assets/T2.mp4', 'assets/x1.png', 'assets/x2.png', 'assets/x3.png'],
    [
      'assets/h4.png','assets/h5.png','assets/h6.png','assets/h7.png','assets/h8.png',
      'assets/h9.png','assets/h10.png','assets/h11.png','assets/h12.png',
      'assets/h13.png','assets/h14.png'
    ],
    ['assets/m1.pdf', 'assets/T2.mp4', 'assets/x1.png', 'assets/x2.png', 'assets/x3.png'],
    [
      'assets/s1.png','assets/ggg1.png','assets/s2.png','assets/s3.png','assets/s4.png',
      'assets/s5.png','assets/s6.png','assets/s7.png','assets/s8.png','assets/s9.png',
      'assets/s10.png','assets/ggg2.png','assets/1x.pdf','assets/1/s.png'
    ],
    ['assets/s1.mp4','assets/s2.mp4','assets/s3.mp4','assets/s4.mp4'],
    ['assets/t1.pdf','assets/t2.pdf','assets/t3.pdf','assets/t4.pdf','assets/1/p1.png','assets/1/p2.png','assets/1/p3.png','assets/1/p4.png','assets/1/p5.png','assets/1/p6.png','assets/1/p7.png','assets/1/pp.png','assets/1/T.png','assets/1/v1.png','assets/1/v2.png','assets/1/v3.png','assets/1/v4.png'],
    ['assets/ui1.mp4','assets/ui2.png','assets/ui3.png','assets/1/i1.png'],
    ['assets/3d.png','assets/1/blender.png'],
    <String>[],
  ];

  List<Map<String, dynamic>> get segments {
    final prefix = () {
      switch (_language) {
        case LanguageMode.arabic:
          return 'ar';
        case LanguageMode.both:
          return 'b';
        case LanguageMode.english:
          return 'en';
      }
    }();
    return List.generate(_mediaLists.length, (i) {
      return {
        'svg': 'assets/${prefix}${i + 1}.svg',
        'media': _mediaLists[i],
      };
    });
  }

  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _directMessageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  String _searchQuery = '';
  bool _ctrlPressed = false;
  bool _dialogOpen = false;
  bool _isDownloadHovered = false;
  bool _isDirectHovered = false;
  bool _isDirectPressed = false;

  static const String _whatsappNumber = '2001065606206';
  static const String _telegramUsername = 'DAROWSHA';
  static const String _cvPdfAsset = 'assets/cv_mostafa_said.pdf';
  static const String _cvPdfFileName = 'cv_mostafa_said.pdf';
  static const String _cvDocAsset = 'assets/cv_ats_Mostafa_said.pdf';
  static const String _cvDocFileName = 'cv_ats_Mostafa_said.pdf';
  static const String _commentsScriptUrl =
      'https://script.google.com/macros/s/AKfycbyQ8zY_shhZ7rTHJm8kxLUVsGV9aPJUE9dWgG0_CKt_ratDwt71GBalHi9Y4DxyE8IvPQ/exec';
  static const String _atsText = '''البيانات الشخصية
مصطفى سعيد عبدالوهاب عبدالرحمن
📍 العنوان: الرحمانية، ميت غمر، الدقهلية – مصر
📞 الهاتف: 01065606206
👤 الحالة الاجتماعية: أعزب
🎂 العمر: 24 سنة

الملخص المهني
معلم حاسب آلي ومصمم تعليمي متمكن يتمتع بخبرة قوية في تصميم المحتوى التفاعلي والتقنيات التعليمية وتطوير البرمجيات. قام بتطوير نظام متكامل لإدارة الوقت يخدم احتياجات المهنيين، والطلاب، والاستخدام الشخصي.

شغوف بالتعلم المستمر وتوظيف أحدث التقنيات لتحسين بيئة التعلم ودعم العمليات الإدارية.

يجيد تحليل البيانات باستخدام Power BI وإنشاء لوحات تحكم تفاعلية تساعد في اتخاذ القرارات، خصوصًا في متابعة الأداء الأكاديمي للطلاب وتحديد نقاط القوة والضعف لديهم بشكل مرئي وواضح.

المسميات الوظيفية
معلم حاسب آلي – إعداد معلم حاسب آلي (ICT) – 2024–2025

مصمم تعليمي تحت إشراف أ.د/ محمد مجدي الشربيني – 2022

مصمم جرافيك ومبرمج – 2022–2025

مطور Flutter & Dart – مصمم واجهات (UI/UX) – 2024

مدخل بيانات وطابع – 2022

المؤهل الدراسي
بكالوريوس التربية النوعية – إعداد معلم الحاسب الآلي
جامعة المنصورة – دفعة 2024
🎓 التقدير: جيد جدًا مع مرتبة الشرف

الدورات والشهادات المعتمدة (2024–2025)
الشهادة	جهة الإصدار
بكالوريوس إعداد معلم الحاسب الآلي	جامعة المنصورة
المستوى الثالث في اللغة الإنجليزية	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
التسويق الرقمي	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
الرخصة الدولية لقيادة الحاسب ICDL	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
مهارات الإدارة	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
المهارات الشخصية	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
السلامة والصحة المهنية	الشهادة الأمريكية (تم الاستلام)
التصميم الجرافيكي	جامعة المنصورة – كلية الهندسة (قيد الاستلام)
دبلومة سفراء الذكاء الاصطناعي	المعهد القومي للاتصالات NTI (قيد الوصول)
دورة المصمم العربي – أ. محمد رجب	(بدون شهادة)

الخبرات العملية
معلم حاسب آلي ورياضيات – مدرسة الشهيد محمد الشافعي بيومي (2024 – حتى الآن)

تدريس مادتي الحاسب الآلي والرياضيات للمرحلة الابتدائية

إعداد دروس تفاعلية وداعمة للمنهج

معلم حاسب آلي – مدرسة الثانوية الجديدة بنات، ميت غمر – (2023–2024)
معلم حاسب آلي – مدرسة التحرير الابتدائية، ميت غمر – (2023)
معلم حاسب آلي – مدرسة خالد بن الوليد الابتدائية، ميت غمر – (2022)

فني طباعة – مطبعة خاصة (2019–2023)

إدارة الإنتاج وتشغيل وصيانة ماكينات الطباعة

متابعة جودة المطبوعات

الإنجازات الجامعية
اختيار مشروع التخرج ضمن أفضل 10 مشاريع والمشاركة في المؤتمر الأول للحاسب الآلي بجامعة المنصورة

حضور مناقشات لشركات تكنو مصر xClan واجتماع مع رئيس جامعة المنصورة

المشاركة في فعاليات مركز التطوير المهني بجامعة المنصورة

المهارات التقنية ونسب الإتقان
برامج أوفيس
Microsoft Word: 90٪

Microsoft Excel: 75٪

Microsoft PowerPoint: 90٪

أدوات التصميم والجرافيك
Articulate Storyline: 85٪

Photoshop: 85٪

Illustrator: 79٪

Adobe XD / Figma: 90٪

InDesign: 85٪

Luminar Neo AI: 90٪

Premiere Pro: 60٪

Audition: 70٪

Blender (تصميم ثلاثي الأبعاد): 45٪

لغات البرمجة
Dart / Flutter: 80٪

C#: 60٪

Visual Basic: 60٪

Python: 30٪

أدوات الذكاء الاصطناعي
هندسة المحفزات (Prompt Engineering): 83٪

ChatGPT / Gemini / DeepAI / Blackbox.AI / GitHub Copilot / AI Programmer: 95٪

Hugging Face / Teachable Machine: 88٪

تحليل البيانات
Power BI: 70٪

أدوات الإنتاجية
سرعة الكتابة على لوحة المفاتيح: 45 كلمة في الدقيقة

نقاط القوة المميزة لوظيفة معلم حاسب آلي
تخطيط دروس مبتكر وتوظيف التقنيات التفاعلية داخل الصف

تصميم محتوى تعليمي رقمي باستخدام Articulate وFigma وAdobe XD

القدرة على تحليل بيانات الطلاب لتحديد الاحتياجات التعليمية بدقة

إتقان البرمجة والتصميم الجرافيكي بما يخدم بيئة التعلم الحديثة


    ..........................^^^^^
    
Mostafa Said Abdelwahab Abdelrahman
📍 Address: El-Rahmaniya, Mit Ghamr, Dakahlia, Egypt
📞 Phone: +20 106 560 6206
👤 Marital Status: Single
🎂 Age: 24 years

Professional Summary
Dedicated ICT Teacher and Instructional Designer with strong expertise in interactive content design, educational technology, and software development. Successfully developed an integrated Time Management System tailored for professionals, students, and personal use.

Passionate about continuous learning and implementing the latest technologies to enhance learning environments and support administrative processes.

Proficient in data analysis with Power BI, creating interactive dashboards to support data-driven decision-making, especially in tracking students’ academic performance and identifying strengths and weaknesses with clear visual insights.

Job Titles
ICT Teacher & Computer Science Educator – 2024–2025

Instructional Designer (Supervised by Prof. Dr. Mohamed Magdy El-Sherbiny) – 2022

Graphic & Software Designer – 2022–2025

Flutter & Dart Developer | UI/UX Designer – 2024

Data Entry Clerk & Typist – 2022

Education
Bachelor of Education in Computer Science, Mansoura University – Class of 2024
🎓 Grade: Very Good with Honors

Certified Courses & Diplomas (2024–2025)
Certificate	Institution
Bachelor's in Computer Science Education	Mansoura University
English Level 3	Mansoura University - Faculty of Engineering (Pending)
Digital Marketing	Mansoura University - Faculty of Engineering (Pending)
ICDL (Word, Excel, PowerPoint, Access, Internet, IT)	Mansoura University - Faculty of Engineering (Pending)
Management Skills	Mansoura University - Faculty of Engineering (Pending)
Personal Skills	Mansoura University - Faculty of Engineering (Pending)
Occupational Safety & Health	American Certification (Received)
Graphic Design	Mansoura University - Faculty of Engineering (Pending)
AI Ambassadors Diploma	National Telecommunication Institute (NTI) (Pending)
Graphic Design Course by Arab Designer Mohamed Ragab	(Attended – No Certificate)

Professional Experience
ICT & Math Teacher, Martyr Mohamed El-Shafie Bayoumi Primary School – 2024–Present

Teaching Computer Science and Mathematics to primary students

Preparing and delivering interactive and engaging lesson plans

ICT Teacher, Mit Ghamr New Girls Secondary School – 2023–2024
ICT Teacher, El-Tahrir Primary School – 2023
ICT Teacher, Khaled Ibn Al-Walid Primary School – 2022

Printing Technician, Private Press – 2019–2023

Managed production schedules and ensured high-quality output

Operated and maintained printing systems

University Achievements
Graduation project selected among the Top 10 and presented at the First Computer Science Conference at Mansoura University

Participated in meetings with Techno Misr xClan Companies and the University President

Contributed to activities at Mansoura University Career Development Center (CDC)

Technical Skills & Proficiency
Office Tools
Word: 90%

Excel: 75%

PowerPoint: 90%

Design & Graphics
Articulate Storyline: 85%

Adobe Photoshop: 85%

Adobe Illustrator: 79%

Adobe XD / Figma: 90%

Adobe InDesign: 85%

Luminar Neo AI: 90%

Adobe Premiere Pro: 60%

Adobe Audition: 70%

Blender (3D Design): 45%

Programming Languages
Dart / Flutter: 80%

C#: 60%

Visual Basic: 60%

Python: 30%

AI Tools
Prompt Engineering AI: 83%

ChatGPT / Gemini / DeepAI / Blackbox.AI / GitHub Copilot / AI Programmer: 95%

Hugging Face / Teachable Machine: 88%

Data Analysis
Power BI: 70%

Productivity Tools
Typing Speed: 45 WPM (Words Per Minute)

Highlights for ICT Teaching Roles
Strong lesson planning and classroom technology integration skills

Experienced in creating digital learning content using Articulate, Figma, Adobe XD, and PowerPoint

Ability to analyze student data to support targeted learning strategies

Fluent in both technical programming and visual communication


    
    
    
    
    
    
    ''';







  @override
  void initState() {
    super.initState();

    // ─── تسجيل الزيارة تلقائيّاً عند فتح الموقع مع جلب الـ IP والدولة ────────────────
    if (kIsWeb) {
      html.HttpRequest.getString('https://ipapi.co/json/')
          .then((resp) {
        final data = jsonDecode(resp);
        final ip = data['ip'] ?? 'Unknown';
        final country = data['country_name'] ?? 'Unknown';
        final url = 'https://script.google.com/macros/s/AKfycbyNfRtSoUgEpjaBkTTGYBS6wBZJBC9yW5ziL9_z--5EkgoCKPRcbKzmt2eFj2dKyafXtw/exec'
            '?ip=${Uri.encodeComponent(ip)}&country=${Uri.encodeComponent(country)}';
        return html.HttpRequest.request(url, method: 'GET').then((resp2) {
          print('تم تسجيل الزيارة: IP=$ip, Country=$country, Response=${resp2.responseText}');
        });
      })
          .catchError((err) {
        print('خطأ في جلب الـ IP/الدولة أو إرسالها: $err');
      });
    }
    // ───────────────────────────────────────────────────────────────────────────────


// ─── WEB‑ONLY: BLOCK RIGHT‑CLICK, DRAG & PRINTSCREEN ─────────────────────────
    if (kIsWeb) {
      // 1) Disable context menu (right‑click)
      html.document.onContextMenu.listen((event) => event.preventDefault());
      // 2) Prevent any drag (including dragging images)
      html.document.onDragStart.listen((event) => event.preventDefault());
      // 3) Intercept PrintScreen key (keyCode 44)
      html.window.onKeyDown.listen((html.KeyboardEvent event) {
        if (event.keyCode == 44) {
          event.preventDefault();
        }
      });
    }
    // ───────────────────────────────────────────────────────────────────────────────

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _commentController.dispose();
    _directMessageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text);
    if (_searchQuery.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _handleKey(RawKeyEvent event) {
    final isCtrl = event.isControlPressed;
    if (_ctrlPressed != isCtrl) setState(() => _ctrlPressed = isCtrl);
  }

  void _showDownloadOptions() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.redAccent, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تحميل السيرة الذاتية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Icons.picture_as_pdf,
                    color: Colors.redAccent,
                    label: 'PDF',
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _confirmBeforeDownloadPdf();
                    },
                  ),
                  _buildOption(
                    icon: Icons.insert_drive_file,
                    color: Colors.blueAccent,
                    label: 'Word ATS',
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (kIsWeb) {
                        final url = Uri.base.resolve(_cvDocAsset).toString();
                        html.AnchorElement(href: url)
                          ..setAttribute('download', _cvDocFileName)
                          ..click();
                      } else {
                        launch(Uri.base.resolve(_cvDocAsset).toString());
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _sendComment(String text) {
    final uri =
        '$_commentsScriptUrl?comment=${Uri.encodeQueryComponent(text)}';
    html.HttpRequest.request(uri, method: 'GET').then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم إرسال رسالتك')));
    }).catchError((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('فشل في إرسال الرسالة')));
    });
  }

  Future<void> _showCommentDialog() async {
    _commentController.clear();
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.green, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'أرسل تعليقاً',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'اكتب تعليقك هنا...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('إلغاء'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      final text = _commentController.text.trim();
                      if (text.isNotEmpty) _sendComment(text);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('إرسال'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDirectMessageDialog() async {
    _directMessageController.clear();
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'إرسال رسالة مباشرة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'برجاء إرسال معلومات للتواصل\n\nشكراً لكم',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _directMessageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'اكتب رسالتك هنا...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('إلغاء'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                    onPressed: () {
                      final msg = _directMessageController.text.trim();
                      if (msg.isNotEmpty) _sendComment(msg);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('إرسال'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentCategory =
    size.width < size.height ? ScreenCategory.small : ScreenCategory.large;
    final defaultLanguage =
    currentCategory == ScreenCategory.small ? LanguageMode.arabic : LanguageMode.both;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_screenCategory != currentCategory) {
        setState(() {
          _screenCategory = currentCategory;
          _language = defaultLanguage;
          _transformationController.value = Matrix4.identity(); // reset zoom when orientation changes
        });
      }
    });

    final bool isMobilePlatform =
        defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS;

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKey,
      autofocus: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
          title: _isSearching
              ? TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'بحث...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
              : MouseRegion(
            onEnter: (_) => setState(() => _isDownloadHovered = true),
            onExit: (_) => setState(() => _isDownloadHovered = false),
            child: GestureDetector(
              onTap: _showDownloadOptions,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download_rounded,
                    size: 32,
                    color: _isDownloadHovered ? Colors.red : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'تحميل السيرة الذاتية',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _searchController.clear();
                    _searchQuery = '';
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
          ],
        ),
        body: GestureDetector(
          onDoubleTapDown: (details) => _doubleTapDetails = details,
          onDoubleTap: () {
            final position = _doubleTapDetails!.localPosition;
            final currentScale = _transformationController.value.getMaxScaleOnAxis();
            const zoom = 2.0;
            final matrix = Matrix4.identity();
            if (currentScale == 1.0) {
              matrix
                ..translate(-position.dx * (zoom - 1), -position.dy * (zoom - 1))
                ..scale(zoom);
            }
            _transformationController.value = matrix;
          },
          child: InteractiveViewer(
            transformationController: _transformationController,
            panEnabled: true,
            scaleEnabled: !_dialogOpen && (_ctrlPressed || isMobilePlatform),
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
                    // أيقونات التواصل والصورة الرئيسية والرسالة المباشرة
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
                              isNarrow
                                  ? const SizedBox(height: 12)
                                  : const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => _showFullScreenMedia('assets/any.png'),
                                child: Image.asset(
                                  'assets/any.png',
                                  width: isNarrow ? constraints.maxWidth * 0.8 : 280,
                                  height: 180,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              isNarrow
                                  ? const SizedBox(height: 8)
                                  : const SizedBox(width: 8),
                              MouseRegion(
                                onEnter: (_) => setState(() => _isDirectHovered = true),
                                onExit: (_) => setState(() => _isDirectHovered = false),
                                child: GestureDetector(
                                  onTap: _showDirectMessageDialog,
                                  onTapDown: (_) => setState(() => _isDirectPressed = true),
                                  onTapUp: (_) => setState(() => _isDirectPressed = false),
                                  onTapCancel: () => setState(() => _isDirectPressed = false),
                                  child: Container(
                                    width: isNarrow ? constraints.maxWidth * 0.8 : null,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: (_isDirectHovered || _isDirectPressed)
                                          ? Colors.lightBlueAccent
                                          : Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'إرسال رسالة مباشرة سرية\nلا تحتاج لأي تسجيلات دخول او انتقالات',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: (_isDirectHovered || _isDirectPressed)
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // أزرار الترجمة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _language = LanguageMode.arabic),
                          child: Column(
                            children: [
                              Icon(Icons.translate, color: Colors.green, size: 60),
                              Text('العربية', style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () => setState(() => _language = LanguageMode.both),
                          child: Column(
                            children: [
                              Icon(Icons.translate, color: Colors.orange, size: 70),
                              Text('اللغتان', style: TextStyle(color: Colors.orange)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () => setState(() => _language = LanguageMode.english),
                          child: Column(
                            children: [
                              Icon(Icons.translate, color: Colors.blue, size: 70),
                              Text('EN', style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // الشرائح حسب اللغة
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

                    // قسم ATS في الأسفل
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            'CV ATS MOSTAFA SAID ABDELWHAB',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SelectableText(
                            _atsText,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMediaGrid(List<String> media, double gridWidth) {
    return Container(
      width: gridWidth,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: media.map((path) {
          final isVideo = path.toLowerCase().endsWith('.mp4');
          final isPdf = path.toLowerCase().endsWith('.pdf');
          double itemSize = (gridWidth * 0.3).clamp(0, 150);
          return GestureDetector(
            onTap: () {
              if (isPdf) _showPdfPopup(path);
              else _showFullScreenMedia(path);
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
                    Image.asset((isVideo || isPdf) ? 'assets/any.png' : path, fit: BoxFit.contain),
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
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: HtmlElementView(viewType: viewId),
          ),
        ),
      );
    } else {
      launch(Uri.base.resolve(assetPath).toString());
    }
  }

  void _showDocPopup(String assetPath) {
    if (kIsWeb) {
      final fileUrl = Uri.base.resolve(assetPath).toString();
      final viewerUrl = 'https://docs.google.com/gview?url=$fileUrl&embedded=true';
      final viewId = 'doc-viewer-${viewerUrl.hashCode}';
      ui.platformViewRegistry.registerViewFactory(viewId, (_) {
        return html.IFrameElement()
          ..src = viewerUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
      });
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: HtmlElementView(viewType: viewId),
          ),
        ),
      );
    } else {
      launch(Uri.base.resolve(assetPath).toString());
    }
  }

  Future<void> _confirmBeforeDownloadPdf() async {
    setState(() => _dialogOpen = true);
    final screen = MediaQuery.of(context).size;
    final dialogW = screen.width * .5;
    final dialogH = screen.height * .8;

    if (kIsWeb) {
      final url = Uri.base.resolve(_cvPdfAsset).toString();
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: dialogW,
            height: dialogH,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded, size: 36, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      _cvPdfFileName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: HtmlElementView(viewType: viewId)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('إلغاء')),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        html.AnchorElement(href: url)
                          ..setAttribute('download', _cvPdfFileName)
                          ..click();
                      },
                      child: const Text('تحميل'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      final bytes = await rootBundle.load(_cvPdfAsset);
      final sizeKB = (bytes.lengthInBytes / 1024).toStringAsFixed(1);
      await showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: dialogW,
            height: dialogH,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('الحجم التقريبي: $sizeKB كيلوبايت'),
                const SizedBox(height: 12),
                Expanded(child: SfPdfViewer.asset(_cvPdfAsset)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('إلغاء')),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _showPdfPopup(_cvPdfAsset);
                      },
                      child: const Text('عرض'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    setState(() => _dialogOpen = false);
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

    // ─── تسجيل الزيارة تلقائيّاً عند فتح الموقع مع جلب الـ IP والدولة ────────────────
    if (kIsWeb) {
      html.HttpRequest.getString('https://ipapi.co/json/')
          .then((resp) {
        final data = jsonDecode(resp);
        final ip = data['ip'] ?? 'Unknown';
        final country = data['country_name'] ?? 'Unknown';
        final url = 'https://script.google.com/macros/s/AKfycbyNfRtSoUgEpjaBkTTGYBS6wBZJBC9yW5ziL9_z--5EkgoCKPRcbKzmt2eFj2dKyafXtw/exec'
            '?ip=${Uri.encodeComponent(ip)}&country=${Uri.encodeComponent(country)}';
        return html.HttpRequest.request(url, method: 'GET').then((resp2) {
          print('تم تسجيل الزيارة: IP=$ip, Country=$country, Response=${resp2.responseText}');
        });
      })
          .catchError((err) {
        print('خطأ في جلب الـ IP/الدولة أو إرسالها: $err');
      });
    }
    // ───────────────────────────────────────────────────────────────────────────────


    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() => _videoDuration = _controller.value.duration);
        _controller.play();
        _controller.addListener(
              () => setState(() => _currentPosition = _controller.value.position),
        );
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
                        onPressed: _seekBackward,
                      ),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        color: Colors.red,
                        onPressed: _togglePlayPause,
                      ),
                      IconButton(
                        icon: const Icon(Icons.forward_10, color: Colors.red),
                        onPressed: _seekForward,
                      ),
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
