import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');
    final textFinder = find.byValueKey('textHello');
    final buttonNavigateFinder = find.byValueKey('btnNavigate');
    final textInputFinder = find.byValueKey('textInput');

    FlutterDriver? driver;

    setUpAll(() async {
      new Directory('screenshots').create();
      driver = await FlutterDriver.connect();
    });

    takeScreenshot(FlutterDriver driver, String path) async {
      final List<int> pixels = await driver.screenshot();
      final File file = new File(path);
      await file.writeAsBytes(pixels);
      print(path);
    }

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    // test('check flutter driver health', () async {
    //   Health health = await driver!.checkHealth();
    //   print(health.status);
    // });

    test('starts at 0', () async {
      expect(await driver!.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      await driver!.tap(buttonFinder);

      expect(await driver!.getText(counterTextFinder), "1");
    });

    // test('text is equal Hello World', () async {
    //   expect(await driver!.getText(textFinder), 'Hello World');
    // });

    test('add text in the text field', () async {
      await driver!.tap(textInputFinder);

      await driver!.enterText('Bernardo', timeout: Duration(seconds: 20));
      await takeScreenshot(driver!, 'screenshots/entered_text_first_name.png');
      await driver!.waitFor(find.text('Bernardo'));

      await driver!.enterText('Bernardo de Oliveira Miranda Junior');
      await takeScreenshot(driver!, 'screenshots/entered_text_full_name.png');

      await driver!.waitFor(find.text('Bernardo de Oliveira Miranda Junior'));
    });

    test('navigate for home', () async {
      await driver!.tap(buttonNavigateFinder);
      final textHomeFinder = find.byValueKey('textHello');
      final buttonHomeFinder = find.byValueKey('ButtonHome');
      await driver!.tap(buttonHomeFinder);
      await takeScreenshot(driver!, 'screenshots/press_button_home.png');

      expect(await driver!.getText(textHomeFinder), "Hello World");
    });

    test('find text alert', () async {
      final textAlertFinder = find.byValueKey('TextAlert');

      expect(await driver!.getText(textAlertFinder), 'ALERTA');
    });
  });
}
