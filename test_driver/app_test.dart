// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dishcord', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final confirmPasswordField = find.byValueKey('confirmPassword');
    final signInButton = find.byValueKey('signIn');
    final goCreateButton = find.byValueKey('goCreate');

    final createAccountButton = find.byValueKey('createAccount');

    final signOutButton = find.byValueKey('signOut');
    final typeMessage = find.byValueKey('typeMessage');
    final sendButton = find.byValueKey('sendButton');
    final chatRoom = find.byValueKey('chatRoom');


    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(goCreateButton);
      await driver.tap(emailField);
      await driver.enterText("betuly4@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("qaz123");

      await driver.tap(confirmPasswordField);
      await driver.enterText("qaz123");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Dish Channels"));
    });

    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(emailField);
      await driver.enterText("betuly4@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("qaz123");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Dish Channels"));
    });

    //test('send a message', () async {
    //  if (await isPresent(signOutButton)) {
    //    await driver.tap(chatRoom);
    //    await driver.tap(typeMessage);
    //    await driver.enterText("waddup dawg");
    //    await driver.tap(sendButton);
//
    //    await driver.waitFor(find.text("waddup dawg"),
    //        timeout: const Duration(seconds: 3));
    //  }
    //});
  });
}
