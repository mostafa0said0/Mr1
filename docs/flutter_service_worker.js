'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/1x.pdf": "9c5f796606df726e04d324b3cb9e1109",
"assets/3d.png": "38b62da5c1a0ddfc53f2a26fb856b917",
"assets/Almarai-ExtraBold.ttf": "5270f5e7ab01259e282604276871946f",
"assets/Almarai-Regular.ttf": "4fcf563640cefe40b7474aec4f966c0a",
"assets/Andalus.ttf": "14e5244f57e2d316dcdd21ba7b9d6f6b",
"assets/any.jpg": "8607380cc753663f0dbb6e723403d35d",
"assets/any.png": "26e711ffec684c04d607c235a2517101",
"assets/ar1.svg": "ff8c6f6bc5b18bb220a739f83fc9aa86",
"assets/ar10.svg": "0f3abe1fc4c663af9c2fa484ad637eed",
"assets/ar11.svg": "5b4cb75d1f190c95623a2d865c48aef3",
"assets/ar2.svg": "1fbfd2a98f9bfdb70f1725c0d8aec410",
"assets/ar3.svg": "91194ac5da268803aa187d9e5df07b14",
"assets/ar4.svg": "8cdfc397c19bac6527d06327824f988f",
"assets/ar5.svg": "8501e8bdc36fa8da21ccf5ffb600d8e7",
"assets/ar6.svg": "bb61326259309adf8dd026fa56133962",
"assets/ar7.svg": "c85807e1a8d9327e80d41abaf6fd4855",
"assets/ar8.svg": "97e0e0a304a10c51439ee1bce78f9014",
"assets/ar9.svg": "7c100adc9f11575720082e445e9749ea",
"assets/AssetManifest.bin": "a262d48a35ff4a2e25296ef698803eca",
"assets/AssetManifest.bin.json": "e6645f9bd4e2cfcfd6de760af6d12ad6",
"assets/AssetManifest.json": "d304f5ceb689246c5c85cc05e994a04c",
"assets/assets/1x.pdf": "9c5f796606df726e04d324b3cb9e1109",
"assets/assets/3d.png": "38b62da5c1a0ddfc53f2a26fb856b917",
"assets/assets/Almarai-ExtraBold.ttf": "5270f5e7ab01259e282604276871946f",
"assets/assets/Almarai-Regular.ttf": "4fcf563640cefe40b7474aec4f966c0a",
"assets/assets/Andalus.ttf": "14e5244f57e2d316dcdd21ba7b9d6f6b",
"assets/assets/any.jpg": "8607380cc753663f0dbb6e723403d35d",
"assets/assets/any.png": "26e711ffec684c04d607c235a2517101",
"assets/assets/ar1.svg": "dd680bd0f2579d545384c03f6fc05067",
"assets/assets/ar10.svg": "b409b0a1a2e6f8a79ed313c739fd8dd3",
"assets/assets/ar11.svg": "e572ec77f14c83dccc385949a9431222",
"assets/assets/ar2.svg": "09ea952cc97a6aaafd1082ce1b2a32f7",
"assets/assets/ar3.svg": "43a6a2828cae0e42677f9de58cdbe01b",
"assets/assets/ar4.svg": "8d193c01f39115ccac7ab9c6deb555f1",
"assets/assets/ar5.svg": "a9f1c9946f589aa0cdfe76f62262a7e0",
"assets/assets/ar6.svg": "f7704d27d8fb9b519a19bb7749b48333",
"assets/assets/ar7.svg": "8cd8a9690e3e9ffbb2621021505d0d0a",
"assets/assets/ar8.svg": "a16f9c43264e8c9af69d7d1dc456f350",
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
"assets/assets/b8.svg": "8adf3ecf1789c653e58bf33b25b32738",
"assets/assets/b9.svg": "acaf232996e68595229e3bf488bce4e2",
"assets/assets/cv_ats_Mostafa_said.docx": "ad164b562242c41fcef3ef760b21dfd6",
"assets/assets/cv_mostafa_said.pdf": "024354e9154d6ff8599550d75f23461e",
"assets/assets/desktop.ini": "ef353e491ee93601bd106cc33ee7a0ab",
"assets/assets/en1.svg": "9e8ff0e151021dd3a5b5ef974f7db722",
"assets/assets/en10.svg": "6bc7b7f4882db680c2faa04cfa961433",
"assets/assets/en11.svg": "a2ea9a5075413e91b2881969cef3e6b0",
"assets/assets/en2.svg": "e1b755f709ba1fc3eaa2aa1576fffe7d",
"assets/assets/en3.svg": "47a5e8e528dff2b444a920391e9fca7d",
"assets/assets/en4.svg": "d2bbb9cac869d42d8d8bc21746394d32",
"assets/assets/en5.svg": "ec91c3c4ff710facbe6eb81bc248f46f",
"assets/assets/en6.svg": "f2ea6ce5bb080c67f7450a852917dc7f",
"assets/assets/en7.svg": "93c0f1350d7ff172327d479b82e2bce8",
"assets/assets/en8.svg": "86eb65a79e1e45f90c0a274142b5cecb",
"assets/assets/en9.svg": "539ad2c9de66e35d14f5c4c510eebaca",
"assets/assets/ggg1.png": "5ade46cc69072bebd567f52cf867589f",
"assets/assets/ggg2.png": "53b18886609519e463e7d4a3586bca95",
"assets/assets/h10.png": "114ea1e75de7c9ac1e3b4fbed915cc8f",
"assets/assets/h11.png": "0c9c93a2a778acb3c60ff8ccb65a3748",
"assets/assets/h12.png": "da64857015c13435cebf9b3e7e91dc4f",
"assets/assets/h13.png": "50421da3178d3ea88f34bdb0459d8a0e",
"assets/assets/h14.png": "3c4f42aec60d0bed6c116e23acf2c57b",
"assets/assets/h15.png": "7ef474c6c6ac2a1db483c5af5e8e8e46",
"assets/assets/h4.png": "79382ff9c351f5ce56b63b261087e9e8",
"assets/assets/h5.png": "44cc18199d6c3baeec6cdb14e0ab80e6",
"assets/assets/h6.png": "c20d18240ab90febcddb9101a8a86582",
"assets/assets/h7.png": "d4b3a9c89373c6e500cf9beed20ee893",
"assets/assets/h8.png": "26e8452d6e58b41979da9244d2622e19",
"assets/assets/h9.png": "0a531a5da4573cd317e1ad994bc37093",
"assets/assets/Harmattan-Bold.ttf": "d470c4e16394ce3bd452c75c8e6aa237",
"assets/assets/Harmattan-Medium.ttf": "0a8dcbe5334296a81cf3b457298210e2",
"assets/assets/Harmattan-Regular.ttf": "bc2ee15747b394efab2c79882f409030",
"assets/assets/Harmattan-SemiBold.ttf": "601e18fdce8da51a61582a93fc3972e8",
"assets/assets/images/g1.svg": "96d03155f099b69ad24b16724c7eaf1d",
"assets/assets/images/g2.svg": "60a229b7a6d29f24a0c8b438815b49f5",
"assets/assets/images/g3.svg": "38f77ac75acbd4dbbee84041373af5de",
"assets/assets/images/g4.svg": "271f43a0edf70922af1e33812697da20",
"assets/assets/images/g5.svg": "5cb2c8b3522b5dcfce3d4448b26f563a",
"assets/assets/images/g555.svg": "341b0ad66cd513abe1986f4d905401a2",
"assets/assets/images/g6.svg": "e7b11cec3d914226cd99ff9639297311",
"assets/assets/images/g7.png": "b38c98bf644e3e077ea66deee1d2a2de",
"assets/assets/images/g7.svg": "c32b8e0708a2f372a354a60f266f7581",
"assets/assets/images/g8.png": "22d09318fb83b5bf26bbf092d4291d5f",
"assets/assets/images/gg.png": "792d2dd9672db938164dacb705882146",
"assets/assets/images/gg.svg": "97fa77d4f71b073dda9e3c434cefed5c",
"assets/assets/images/p5.svg": "bdfacfde44ca3cc0fb4cf38696548da8",
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
"assets/assets/t1.pdf": "a017b8eda82f85a0f648d2695c2a148a",
"assets/assets/t2.pdf": "e9719dbea916e1c7e98e9ea218cecb21",
"assets/assets/t3.pdf": "dec0c57d007f2fb6fbc3ce40ede55382",
"assets/assets/t4.pdf": "f921a841654eba90b4dad14737732b81",
"assets/assets/telegram.json": "e7e81af5f9213f38fdc082cc672b36f2",
"assets/assets/ui1.mp4": "b58fbf77c0b88a4f673ae80aef642325",
"assets/assets/ui2.png": "a1b52dc4c926ce6d51a367931151152d",
"assets/assets/ui2.svg": "74b204bb48adcb484f45d3cee0c9e481",
"assets/assets/ui3.png": "7449053e7adf0c84695ce09ece2835d4",
"assets/assets/ui3.svg": "e2c85db04aa954330e58e4448a60116e",
"assets/assets/whats.json": "3360236a865edf9fc95f4ced44674d70",
"assets/assets/x.png": "0f5a0754c6d25710967a7006ae76ea0a",
"assets/b1.svg": "53217c6f796e5805d0b780214d96f30d",
"assets/b10.svg": "0f44e1a4168ba114002bb407aa654699",
"assets/b11.svg": "20e55621d4b7b9af5c21bb7722caeb9b",
"assets/b2.svg": "f477dcd3eec19ae1e720892854471343",
"assets/b3.svg": "fee8515faf4b357ce6524b9e85166ba1",
"assets/b4.svg": "e6fc8654bbbca3b470429b727201ec47",
"assets/b5.svg": "3bab7065d0582a848e9869a66ad51701",
"assets/b6.svg": "01451ef4d71170f02472751fad93f129",
"assets/b7.svg": "789c5cb42dd2c994c6c1c66039bbc937",
"assets/b8.svg": "a7b304efcfe84a43d4ba73f8bd890cff",
"assets/b9.svg": "cc8df1adabfb66cbc80bb096da9eeb02",
"assets/cv_ats_Mostafa_said.docx": "ad164b562242c41fcef3ef760b21dfd6",
"assets/cv_mostafa_said.pdf": "024354e9154d6ff8599550d75f23461e",
"assets/desktop.ini": "ef353e491ee93601bd106cc33ee7a0ab",
"assets/en1.svg": "0e4fc16100b15eed519d71320d637f8b",
"assets/en10.svg": "37fbe5d757018857b9f4241f11e0d980",
"assets/en11.svg": "d8054e0e43a5358f96f31ee1a65c6b44",
"assets/en2.svg": "d429a682fd7b195db7aa09c5f1476367",
"assets/en3.svg": "82a44c35905e1870ec0e9ddc387f2089",
"assets/en4.svg": "918141b88eee050e2ca4a697c43fd089",
"assets/en5.svg": "c911dfec99e6fb8aa2f1f7858028bf2a",
"assets/en6.svg": "e346e64cf5043049293493128043bcac",
"assets/en7.svg": "be3fc51114b32822687c15c13b73fe43",
"assets/en8.svg": "40e094fefb29a5f73a7bad99820067ce",
"assets/en9.svg": "2f2c2c99e47d3bddd9f0ae71ecf532a2",
"assets/FontManifest.json": "a735cf4700d1ee1ba6f32610704dcaab",
"assets/fonts/MaterialIcons-Regular.otf": "cf07cee44108caee0650efec6832c29b",
"assets/ggg1.png": "5ade46cc69072bebd567f52cf867589f",
"assets/ggg2.png": "53b18886609519e463e7d4a3586bca95",
"assets/h10.png": "114ea1e75de7c9ac1e3b4fbed915cc8f",
"assets/h11.png": "0c9c93a2a778acb3c60ff8ccb65a3748",
"assets/h12.png": "da64857015c13435cebf9b3e7e91dc4f",
"assets/h13.png": "50421da3178d3ea88f34bdb0459d8a0e",
"assets/h14.png": "3c4f42aec60d0bed6c116e23acf2c57b",
"assets/h15.png": "7ef474c6c6ac2a1db483c5af5e8e8e46",
"assets/h4.png": "79382ff9c351f5ce56b63b261087e9e8",
"assets/h5.png": "44cc18199d6c3baeec6cdb14e0ab80e6",
"assets/h6.png": "c20d18240ab90febcddb9101a8a86582",
"assets/h7.png": "d4b3a9c89373c6e500cf9beed20ee893",
"assets/h8.png": "26e8452d6e58b41979da9244d2622e19",
"assets/h9.png": "0a531a5da4573cd317e1ad994bc37093",
"assets/Harmattan-Bold.ttf": "d470c4e16394ce3bd452c75c8e6aa237",
"assets/Harmattan-Medium.ttf": "0a8dcbe5334296a81cf3b457298210e2",
"assets/Harmattan-Regular.ttf": "bc2ee15747b394efab2c79882f409030",
"assets/Harmattan-SemiBold.ttf": "601e18fdce8da51a61582a93fc3972e8",
"assets/images/g1.svg": "96d03155f099b69ad24b16724c7eaf1d",
"assets/images/g2.svg": "60a229b7a6d29f24a0c8b438815b49f5",
"assets/images/g3.svg": "38f77ac75acbd4dbbee84041373af5de",
"assets/images/g4.svg": "271f43a0edf70922af1e33812697da20",
"assets/images/g5.svg": "5cb2c8b3522b5dcfce3d4448b26f563a",
"assets/images/g555.svg": "341b0ad66cd513abe1986f4d905401a2",
"assets/images/g6.svg": "e7b11cec3d914226cd99ff9639297311",
"assets/images/g7.png": "b38c98bf644e3e077ea66deee1d2a2de",
"assets/images/g7.svg": "c32b8e0708a2f372a354a60f266f7581",
"assets/images/g8.png": "22d09318fb83b5bf26bbf092d4291d5f",
"assets/images/gg.png": "792d2dd9672db938164dacb705882146",
"assets/images/gg.svg": "97fa77d4f71b073dda9e3c434cefed5c",
"assets/images/p5.svg": "bdfacfde44ca3cc0fb4cf38696548da8",
"assets/m1.png": "90d70be3edd6d1f4d31ee2e2daab0dde",
"assets/NOTICES": "2d41a4f7397163da0222fb6716acf152",
"assets/p.pdf": "8937209421474f689b293e439b80ec13",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/s1.mp4": "a841886bd7d75df22adb3513c05b6f9f",
"assets/s1.png": "f1ca216ecebe9f4b20ed09b55488ac15",
"assets/s10.png": "832d268bd134a5fce05a696b52655f22",
"assets/s11.jpg": "c884e2d898ea3dce56d908177d8a65b7",
"assets/s12.jpg": "47238dcff42f848f7941b237f9a46ce2",
"assets/s13.jpg": "0cab8c6fc2463ef86900b24761d24057",
"assets/s2.mp4": "0ecdd23c5a9548f546f206c81dd4490f",
"assets/s2.png": "0694d5153cf49605a25aab24c1884def",
"assets/s3.mp4": "4bbd5c12635d347cb7d265cd2dd89d7d",
"assets/s3.png": "3117a0de90e887294da4aa807ca9b8d0",
"assets/s4.mp4": "51ab15f1c22f0f3b00ecbd74dc1c5aa3",
"assets/s4.png": "fdf1f44dd3ce69b63965442bd98bf583",
"assets/s5.png": "f0e089e82052e4137ca27f9a9c0badd6",
"assets/s6.png": "b12eb2330d0ef2c1af7590e3ee43fbe9",
"assets/s7.png": "2bd8b0f82f25d0ece99f7a2879895a5b",
"assets/s8.png": "e1e587feec5718b71ed9d1434b413a11",
"assets/s9.png": "003b9306b9a910cba7490e68e2224060",
"assets/sh1.png": "407529fd52721ba0e4398a5120a727d6",
"assets/sh2.png": "83feeff8d8eda3355b3b81d5901e0515",
"assets/sh3.png": "b32118ac93fa1884293e2f9fd83aae27",
"assets/sh4.png": "7286c7c145c0d73002e05763c4d473fc",
"assets/sh5.png": "9e014734f43fcf062b6894105137488a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/sm.png": "58466de30933c021f62371fd1ad7da95",
"assets/sound.mp3": "dd09363efec2df2d7d19a2ddd053b0a1",
"assets/t1.pdf": "a017b8eda82f85a0f648d2695c2a148a",
"assets/t2.pdf": "e9719dbea916e1c7e98e9ea218cecb21",
"assets/t3.pdf": "dec0c57d007f2fb6fbc3ce40ede55382",
"assets/t4.pdf": "f921a841654eba90b4dad14737732b81",
"assets/telegram.json": "e7e81af5f9213f38fdc082cc672b36f2",
"assets/ui1.mp4": "b58fbf77c0b88a4f673ae80aef642325",
"assets/ui2.png": "a1b52dc4c926ce6d51a367931151152d",
"assets/ui2.svg": "74b204bb48adcb484f45d3cee0c9e481",
"assets/ui3.png": "7449053e7adf0c84695ce09ece2835d4",
"assets/ui3.svg": "e2c85db04aa954330e58e4448a60116e",
"assets/whats.json": "3360236a865edf9fc95f4ced44674d70",
"assets/x.png": "0f5a0754c6d25710967a7006ae76ea0a",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
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
"flutter_bootstrap.js": "e9eeeff6839f6bb7e49eb1bb283f3340",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-192.png.png": "f44be89722c5108d8d35f0a066e67aad",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "e1015c0d76e2b48989f8ad4187570344",
"/": "e1015c0d76e2b48989f8ad4187570344",
"main.dart.js": "0421a23226e41c1bcaeb74743f3b8e5a",
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
