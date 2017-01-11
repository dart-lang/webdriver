// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library webdriver.alert_test;

import 'package:test/test.dart';
import 'package:webdriver/core.dart';

import 'test_util.dart';

void main() {
  group('Alert', () {
    WebDriver driver;
    WebElement button;
    WebElement output;

    setUp(() async {
      driver = await createTestDriver();
      await driver.get(testPagePath);
      button = await driver.findElement(const By.tagName('button'));
      output = await driver.findElement(const By.id('settable'));
    });

    tearDown(() async {
      if (driver != null) {
        await driver.quit();
      }
      driver = null;
    });

    test('no alert', () {
      expect(driver.switchTo.alert, throws);
    });

    test('text', () async {
      await button.click();
      var alert = await driver.switchTo.alert;
      expect(alert.text, 'button clicked');
      await alert.dismiss();
    });

    test('accept', () async {
      await button.click();
      var alert = await driver.switchTo.alert;
      await alert.accept();
      expect(await output.text, startsWith('accepted'));
    });

    test('dismiss', () async {
      await button.click();
      var alert = await driver.switchTo.alert;
      await alert.dismiss();
      expect(await output.text, startsWith('dismissed'));
    });

    test('sendKeys', () async {
      await button.click();
      Alert alert = await driver.switchTo.alert;
      await alert.sendKeys('some keys');
      await alert.accept();
      expect(await output.text, endsWith('some keys'));
    });
  });
}
