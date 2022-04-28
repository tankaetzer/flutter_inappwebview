import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants.dart';
import '../util.dart';

void customMenuItem() {
  final shouldSkip = kIsWeb ||
      ![
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);

  test('add custom menu item', () async {
    var chromeSafariBrowser = new MyChromeSafariBrowser();
    chromeSafariBrowser.addMenuItem(ChromeSafariBrowserMenuItem(
        id: 2,
        label: 'Custom item menu 1',
        action: (url, title) {
          print('Custom item menu 1 clicked!');
        }));
    expect(chromeSafariBrowser.isOpened(), false);

    await chromeSafariBrowser.open(
        url: TEST_URL_1);
    await chromeSafariBrowser.browserCreated.future;
    expect(chromeSafariBrowser.isOpened(), true);
    expect(() async {
      await chromeSafariBrowser.open(url: TEST_CROSS_PLATFORM_URL_1);
    }, throwsA(isInstanceOf<ChromeSafariBrowserAlreadyOpenedException>()));

    await expectLater(chromeSafariBrowser.firstPageLoaded.future, completes);
    await chromeSafariBrowser.close();
    await chromeSafariBrowser.browserClosed.future;
    expect(chromeSafariBrowser.isOpened(), false);
  }, skip: shouldSkip);
}
