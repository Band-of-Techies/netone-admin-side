'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "dbe67ffe109d611ab0e7a37df40f9c71",
"index.html": "bcdda74be375c8386a79ecff7edf7908",
"/": "bcdda74be375c8386a79ecff7edf7908",
"main.dart.js": "e3729f7050b3893fbf8a1ed423a98bbb",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "2fff51c687bd750e5768665445e75877",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f413dba59ebf3fbf3f2d504591179033",
"assets/AssetManifest.json": "3b2abb37d60d755733557afae3179e46",
"assets/NOTICES": "5ddfba1c9a80e338beab9209cfd79022",
"assets/FontManifest.json": "1b2a5eab9d4d3abd26edbab0b5a992db",
"assets/AssetManifest.bin.json": "9c739ebcb24ff8f838b4f193acdd2152",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "9719910c7a7b280a6200801cc1597581",
"assets/fonts/MaterialIcons-Regular.otf": "93bae2bedf19e9e591272cda045cb90c",
"assets/assets/svg/login.svg": "d46902f38e2c8d981aa71eb459a90472",
"assets/assets/svg/facebook.svg": "150a1b092f7650264b3e2e9d28f99e7b",
"assets/assets/svg/google.svg": "213b9d3a460d5c35d633528fb50f2e93",
"assets/assets/svg/logo.svg": "3a0e9d5fccb9266fe2ba6fb4a60c08f8",
"assets/assets/svg/confirm.svg": "a11f50bac8bd138eb46c4bf16f632f3e",
"assets/assets/tick.png": "d98758a8752688149a65d990e9d45ab1",
"assets/assets/form8.jpg": "d2a84b1086f6e0c97be260d23792bf35",
"assets/assets/form9.jpg": "66d4dff31aaaf9e3f82251cf907e2172",
"assets/assets/sign.jpg": "b7108a826f775c3039dd66d1e449440b",
"assets/assets/sign.png": "691a859bb6027423b47808567464bc81",
"assets/assets/png/avatar-1.png": "038abc501087aefce746e3cb7fb8494b",
"assets/assets/png/avatar-2.png": "0fe16aa5bd1c9033f32d71ddb993c91f",
"assets/assets/png/avatar-3.png": "53437fa458fc601e4b96c25c2e1507f9",
"assets/assets/png/avatar-7.png": "46ddd2bad19579e222454be61d251fee",
"assets/assets/png/agent.png": "8e22f2f8d64c96c41bf7de958b51edff",
"assets/assets/png/avatar-6.png": "b45be2fdfb522cc3687cd2701afb1a97",
"assets/assets/png/avatar-4.png": "6140a06fa0ab4908aa8a935f951cd8d2",
"assets/assets/png/avatar-5.png": "bd608d7293941c6df8b9acd5b36faa7f",
"assets/assets/png/netone.png": "7ab05b04d2aab4042e4f2d01cf64aca8",
"assets/assets/png/confirm.png": "6df810afceecd3df8dfccc4a0b3cd31d",
"assets/assets/png/logo.png": "55a0136efebb6387418ec4a90fbfcc11",
"assets/assets/png/in-stock.png": "8cfbe8d08680f706d56b39879a382851",
"assets/assets/png/joint.png": "f01fbbe6ef5bbc7c7f117efdc99bd1ed",
"assets/assets/png/avatar-8.png": "8d36c0d6cea93a38a175c21a01ccc6d0",
"assets/assets/png/logo.svg": "62b6925fa54ee4a77658e4d45e589b5e",
"assets/assets/form14.jpg": "a5310ce5355977c0740e2d278c8fdeff",
"assets/assets/form15.jpg": "44c4786b183814f8131e1e15b2301d6b",
"assets/assets/quote.jpg": "ca29296dd90d2f026e60b7bf0df893e5",
"assets/assets/form12.jpg": "c6ee1bdb71a0b3b3fc2e272c1ad769cf",
"assets/assets/form13.jpg": "7d1c2086ed8b74bf71310d75867f7bd9",
"assets/assets/form11.jpg": "6732f58fb48d189098991e421c3dda2a",
"assets/assets/form10.jpg": "6e49614eb9ec284768416263076d77ac",
"assets/assets/form7.jpg": "9ee2253da0980879f44c440503c3a57b",
"assets/assets/font/DM_Sans/DMSans-Regular.ttf": "7c217bc9433889f55c38ca9d058514d3",
"assets/assets/font/DM_Sans/DMSans-Medium.ttf": "24bfda9719b2ba60b94a0f9412757d10",
"assets/assets/font/DM_Sans/DMSans-Bold.ttf": "b9cec5212f09838534e6215d1f23ed55",
"assets/assets/font/DM_Sans/DMSans-BoldItalic.ttf": "f83322c859de9fce83f15d5e6714d78d",
"assets/assets/font/DM_Sans/DMSans-MediumItalic.ttf": "a72ea4b3c89082b9308ef3fcabff9824",
"assets/assets/font/DM_Sans/DMSans-Italic.ttf": "1ea925903e098f94f5c51566770a2da8",
"assets/assets/form6.jpg": "390f4c88732ab038f82a201510c90a02",
"assets/assets/form4.jpg": "e1e83904a626cdeb0e11f7d67fef2bab",
"assets/assets/form5.jpg": "16ba382a410b171a4d5ac38a13a6b35a",
"assets/assets/form1.jpg": "e0c081edd73ccfd5894b81147cd5b92c",
"assets/assets/form2.jpg": "dddff07e3f057eb84b1328f99fd533c7",
"assets/assets/form3.jpg": "fd3ca0491ce2c1740206d995791411d7",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
