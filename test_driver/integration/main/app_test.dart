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
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

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

    test('enter text in inputText', () async {
      await driver!.tap(textInputFinder);

      await driver!.enterText('Bernardo', timeout: Duration(seconds: 20));

      await driver!.waitFor(find.text('Bernardo'));

      await driver!.enterText('Bernardo de Oliveira Miranda Junior',
          timeout: Duration(seconds: 2000));

      await driver!.waitFor(find.text('Bernardo de Oliveira Miranda Junior'));
    });

    test('navigate for home', () async {
      await driver!.tap(buttonNavigateFinder);

      await driver!.getWidgetDiagnostics(buttonNavigateFinder);
    });
  }, timeout: Timeout(Duration(seconds: 4000)));
}
