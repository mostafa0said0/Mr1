'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ae5e024d4917a54fe5872724ce0ca2ce",
"assets/AssetManifest.bin.json": "483cc45007c125078520c50873fcb2fc",
"assets/AssetManifest.json": "308bdc98d874b44a744e75acd145145e",
"assets/assets/1/blender.png": "0198a07a94ad7e02b2592ead56b823e1",
"assets/assets/1/i1.png": "82bcbf26f118302e0123150c27d27ec9",
"assets/assets/1/p1.png": "e08a31959fa43746c6e1bfbc089f9ac8",
"assets/assets/1/p2.png": "4f2eed6bbdf440c669c1e6dddc50329f",
"assets/assets/1/p3.png": "cd5ac6bd79f72621798f44492237d5b9",
"assets/assets/1/p4.png": "65b920d4fa0686a86137800d7cc71075",
"assets/assets/1/p5.png": "04429c73ba0065a7850e04b65402a910",
"assets/assets/1/p6.png": "8b4ce2194849dca197edd67e0bf5ce8b",
"assets/assets/1/p7.png": "61122266d1ae94d24f83308102ea80c9",
"assets/assets/1/pp.png": "8e374d5d8fc95fba23e9f46cd808c0e2",
"assets/assets/1/s.png": "6fd04e774c98f68fb2042b675b62c8ab",
"assets/assets/1/T.png": "4625e7f8ca4bf85b2dac370a5e7e84d0",
"assets/assets/1/v1.png": "c4aea1b92d909ac17433dca243e2e470",
"assets/assets/1/v2.png": "311c91dd1137e6a1bbae9dfc066f6f65",
"assets/assets/1/v3.png": "a87b7257ff6586334c6775da437e89b6",
"assets/assets/1/v4.png": "f6491ab483c34de609b0be56bb86034d",
"assets/assets/1x.pdf": "9c5f796606df726e04d324b3cb9e1109",
"assets/assets/3d.png": "38b62da5c1a0ddfc53f2a26fb856b917",
"assets/assets/Almarai-ExtraBold.ttf": "5270f5e7ab01259e282604276871946f",
"assets/assets/Almarai-Regular.ttf": "4fcf563640cefe40b7474aec4f966c0a",
"assets/assets/Andalus.ttf": "14e5244f57e2d316dcdd21ba7b9d6f6b",
"assets/assets/any.png": "9ec20c1450283773ea8e7f2341ea4daa",
"assets/assets/ar1.svg": "dd680bd0f2579d545384c03f6fc05067",
"assets/assets/ar10.svg": "b409b0a1a2e6f8a79ed313c739fd8dd3",
"assets/assets/ar11.svg": "e572ec77f14c83dccc385949a9431222",
"assets/assets/ar2.svg": "09ea952cc97a6aaafd1082ce1b2a32f7",
"assets/assets/ar3.svg": "43a6a2828cae0e42677f9de58cdbe01b",
"assets/assets/ar4.svg": "8d193c01f39115ccac7ab9c6deb555f1",
"assets/assets/ar5.svg": "a9f1c9946f589aa0cdfe76f62262a7e0",
"assets/assets/ar6.svg": "f7704d27d8fb9b519a19bb7749b48333",
"assets/assets/ar7.svg": "8cd8a9690e3e9ffbb2621021505d0d0a",
"assets/assets/ar8.svg": "ebb68b379de11a61bde415e1cd5d6f72",
"assets/assets/ar9.svg": "ed5490c5377075cd9122804416d4b87c",
"assets/assets/b1.svg": "90a6a7a04be7ad78bec97992311b312f",
"assets/assets/b10.svg": "744b3b3d949e4400919b4f75903fa8ba",
"assets/assets/b11.svg": "65e705ee16b7ffe76e9e18e22455e1ca",
"assets/assets/b2.svg": "af44297d3f1dfed7a6573e5bc27da33f",
"assets/assets/b3.svg": "78055f5505d73b79631b35a145d635ba",
"assets/assets/b4.svg": "baf4f5046e72763ad11c14c258e6aa71",
"assets/assets/b5.svg": "4d56b402fb3f35e49c51331d97e4b3e4",
"assets/assets/b6.svg": "66b8c006491efee00b1ce2578354c4f1",
"assets/assets/b7.svg": "d8fe514320b20dd069d69da57ced78d3",
"assets/assets/b8.svg": "93f1778796219d4aad80031801777387",
"assets/assets/b9.svg": "acaf232996e68595229e3bf488bce4e2",
"assets/assets/cv_ats_Mostafa_said.docx": "74e892704b186c718e0415bd2f4626a9",
"assets/assets/cv_mostafa_said.pdf": "a3d1982e23ce13a1b7b1a3cba9674ff9",
"assets/assets/en1.svg": "9e8ff0e151021dd3a5b5ef974f7db722",
"assets/assets/en10.svg": "6bc7b7f4882db680c2faa04cfa961433",
"assets/assets/en11.svg": "a2ea9a5075413e91b2881969cef3e6b0",
"assets/assets/en2.svg": "e1b755f709ba1fc3eaa2aa1576fffe7d",
"assets/assets/en3.svg": "47a5e8e528dff2b444a920391e9fca7d",
"assets/assets/en4.svg": "d2bbb9cac869d42d8d8bc21746394d32",
"assets/assets/en5.svg": "ec91c3c4ff710facbe6eb81bc248f46f",
"assets/assets/en6.svg": "f2ea6ce5bb080c67f7450a852917dc7f",
"assets/assets/en7.svg": "93c0f1350d7ff172327d479b82e2bce8",
"assets/assets/en8.svg": "317e88534a8f9746ca99fd68d4b8f6d1",
"assets/assets/en9.svg": "539ad2c9de66e35d14f5c4c510eebaca",
"assets/assets/ggg1.png": "5ade46cc69072bebd567f52cf867589f",
"assets/assets/ggg2.png": "53b18886609519e463e7d4a3586bca95",
"assets/assets/h10.png": "114ea1e75de7c9ac1e3b4fbed915cc8f",
"assets/assets/h11.png": "0c9c93a2a778acb3c60ff8ccb65a3748",
"assets/assets/h12.png": "da64857015c13435cebf9b3e7e91dc4f",
"assets/assets/h13.png": "50421da3178d3ea88f34bdb0459d8a0e",
"assets/assets/h14.png": "3c4f42aec60d0bed6c116e23acf2c57b",
"assets/assets/h4.png": "79382ff9c351f5ce56b63b261087e9e8",
"assets/assets/h5.png": "44cc18199d6c3baeec6cdb14e0ab80e6",
"assets/assets/h6.png": "c20d18240ab90febcddb9101a8a86582",
"assets/assets/h7.png": "d4b3a9c89373c6e500cf9beed20ee893",
"assets/assets/h8.png": "26e8452d6e58b41979da9244d2622e19",
"assets/assets/h9.png": "0a531a5da4573cd317e1ad994bc37093",
"assets/assets/Harmattan-Bold.ttf": "d470c4e16394ce3bd452c75c8e6aa237",
"assets/assets/images/g1.svg": "96d03155f099b69ad24b16724c7eaf1d",
"assets/assets/images/g2.svg": "60a229b7a6d29f24a0c8b438815b49f5",
"assets/assets/images/g3.svg": "38f77ac75acbd4dbbee84041373af5de",
"assets/assets/images/g4.svg": "271f43a0edf70922af1e33812697da20",
"assets/assets/images/g5.svg": "5cb2c8b3522b5dcfce3d4448b26f563a",
"assets/assets/images/g6.svg": "e7b11cec3d914226cd99ff9639297311",
"assets/assets/images/gg.svg": "97fa77d4f71b073dda9e3c434cefed5c",
"assets/assets/m1.png": "90d70be3edd6d1f4d31ee2e2daab0dde",
"assets/assets/p.pdf": "8937209421474f689b293e439b80ec13",
"assets/assets/s1.mp4": "a841886bd7d75df22adb3513c05b6f9f",
"assets/assets/s1.png": "f1ca216ecebe9f4b20ed09b55488ac15",
"assets/assets/s10.png": "832d268bd134a5fce05a696b52655f22",
"assets/assets/s11.jpg": "c884e2d898ea3dce56d908177d8a65b7",
"assets/assets/s12.jpg": "47238dcff42f848f7941b237f9a46ce2",
"assets/assets/s13.jpg": "0cab8c6fc2463ef86900b24761d24057",
"assets/assets/s2.mp4": "0ecdd23c5a9548f546f206c81dd4490f",
"assets/assets/s2.png": "0694d5153cf49605a25aab24c1884def",
"assets/assets/s3.mp4": "4bbd5c12635d347cb7d265cd2dd89d7d",
"assets/assets/s3.png": "3117a0de90e887294da4aa807ca9b8d0",
"assets/assets/s4.mp4": "51ab15f1c22f0f3b00ecbd74dc1c5aa3",
"assets/assets/s4.png": "fdf1f44dd3ce69b63965442bd98bf583",
"assets/assets/s5.png": "f0e089e82052e4137ca27f9a9c0badd6",
"assets/assets/s6.png": "b12eb2330d0ef2c1af7590e3ee43fbe9",
"assets/assets/s7.png": "2bd8b0f82f25d0ece99f7a2879895a5b",
"assets/assets/s8.png": "e1e587feec5718b71ed9d1434b413a11",
"assets/assets/s9.png": "003b9306b9a910cba7490e68e2224060",
"assets/assets/sh1.png": "407529fd52721ba0e4398a5120a727d6",
"assets/assets/sh2.png": "83feeff8d8eda3355b3b81d5901e0515",
"assets/assets/sh3.png": "b32118ac93fa1884293e2f9fd83aae27",
"assets/assets/sh4.png": "7286c7c145c0d73002e05763c4d473fc",
"assets/assets/sh5.png": "9e014734f43fcf062b6894105137488a",
"assets/assets/sm.png": "58466de30933c021f62371fd1ad7da95",
"assets/assets/sound.mp3": "dd09363efec2df2d7d19a2ddd053b0a1",
"assets/assets/t2.pdf": "e9719dbea916e1c7e98e9ea218cecb21",
"assets/assets/t3.pdf": "dec0c57d007f2fb6fbc3ce40ede55382",
"assets/assets/t4.pdf": "f921a841654eba90b4dad14737732b81",
"assets/assets/telegram.json": "e7e81af5f9213f38fdc082cc672b36f2",
"assets/assets/ui1.mp4": "b58fbf77c0b88a4f673ae80aef642325",
"assets/assets/ui2.png": "a1b52dc4c926ce6d51a367931151152d",
"assets/assets/ui3.png": "7449053e7adf0c84695ce09ece2835d4",
"assets/assets/whats.json": "3360236a865edf9fc95f4ced44674d70",
"assets/FontManifest.json": "a735cf4700d1ee1ba6f32610704dcaab",
"assets/fonts/MaterialIcons-Regular.otf": "cf07cee44108caee0650efec6832c29b",
"assets/NOTICES": "d3231cd2e23bdbcb8ea2902b79815a5d",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "50d3f47a68412dd5bc50126fe2db6d12",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e1015c0d76e2b48989f8ad4187570344",
"/": "e1015c0d76e2b48989f8ad4187570344",
"main.dart.js": "2b94598ebafcc9b0d767768f93d30c9f",
"manifest.json": "3f5cc1422384871cb04bfcbe05618047",
"version.json": "53fb59e54fb87bb44dba7c2200e1dead"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
