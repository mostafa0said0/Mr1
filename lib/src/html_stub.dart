// lib/src/html_stub.dart

// ستباً بسيطاً لتعريف الـ APIs المستعملة على الموبايل
class HttpRequest {
  static Future<HttpRequest> request(String uri, {String method = 'GET'}) async => HttpRequest();
// إذا احتجت then/catchError أضفها هنا
}

class AnchorElement {
  AnchorElement({String? href});
  void setAttribute(String name, String value) {}
  void click() {}
}

class IFrameElement {}

// لتسجيل ViewFactories (ويب فقط)
class platformViewRegistry {
  static void registerViewFactory(String viewId, Function viewFactory) {}
}
