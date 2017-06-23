// Copyright 2017 Google Inc. All Rights Reserved.
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

@TestOn("vm")
library webdriver.spec_inference_test;

import 'package:test/test.dart';
import 'package:webdriver/sync_core.dart';

import 'sync_io_config.dart' as config;

void main() {
  group('Spec inference', () {
    WebDriver driver;

    setUp(() {});

    tearDown(() {
      if (driver != null) {
        driver.quit();
      }
      driver = null;
    });

    test('chrome works', () {
      driver = config.createChromeTestDriver(spec: WebDriverSpec.Auto);
      driver.get(config.testPagePath);
      final button = driver.findElement(const By.tagName('button'));
      try {
        button.findElement(const By.tagName('tr'));
        throw 'Expected NoSuchElementException';
      } on NoSuchElementException {}
    });

    test('firefox work', () {
      driver = config.createFirefoxTestDriver(spec: WebDriverSpec.Auto);
      driver.get(config.testPagePath);
      final button = driver.findElement(const By.tagName('button'));
      try {
        button.findElement(const By.tagName('tr'));
        throw 'Expected Exception';
      } on Exception {} // TODO(staats): update exception type.
    });
  }, timeout: new Timeout(new Duration(minutes: 2)));
}
