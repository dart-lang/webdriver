library webdriver_test.web_element;

import 'package:unittest/unittest.dart';
import 'package:webdriver/webdriver.dart';

import '../test_util.dart';

void main() {
  group('WebElement', () {
    WebDriver driver;
    WebElement table;
    WebElement button;
    WebElement form;
    WebElement textInput;
    WebElement checkbox;
    WebElement disabled;
    WebElement invisible;

    setUp(() async {
      driver = await createTestDriver();
      await driver.get(testPagePath);
      table = await driver.findElement(new By.tagName('table'));
      button = await driver.findElement(new By.tagName('button'));
      form = await driver.findElement(new By.tagName('form'));
      textInput =
          await driver.findElement(new By.cssSelector('input[type=text]'));
      checkbox =
          await driver.findElement(new By.cssSelector('input[type=checkbox]'));
      disabled =
          await driver.findElement(new By.cssSelector('input[type=password]'));
      invisible = await driver.findElement(new By.tagName('div'));
    });

    tearDown(() => driver.quit());

    test('click', () async {
      await button.click();
      var alert = await driver.switchTo.alert;
      await alert.accept();
    });

    test('submit', () async {
      await form.submit();
      var alert = await driver.switchTo.alert;
      expect(alert.text, 'form submitted');
      await alert.accept();
    });

    test('sendKeys', () async {
      await textInput.sendKeys('some keys');
      expect(await textInput.attributes['value'], 'some keys');
    });

    test('clear', () async {
      await textInput.sendKeys('some keys');
      await textInput.clear();
      expect(await textInput.attributes['value'], '');
    });

    test('enabled', () async {
      expect(await table.enabled, isTrue);
      expect(await button.enabled, isTrue);
      expect(await form.enabled, isTrue);
      expect(await textInput.enabled, isTrue);
      expect(await checkbox.enabled, isTrue);
      expect(await disabled.enabled, isFalse);
    });

    test('displayed', () async {
      expect(await table.displayed, isTrue);
      expect(await button.displayed, isTrue);
      expect(await form.displayed, isTrue);
      expect(await textInput.displayed, isTrue);
      expect(await checkbox.displayed, isTrue);
      expect(await disabled.displayed, isTrue);
      expect(await invisible.displayed, isFalse);
    });

    test('location -- table', () async {
      var location = await table.location;
      expect(location, isPoint);
      expect(location.x, isNonNegative);
      expect(location.y, isNonNegative);
    });

    test('location -- invisible', () async {
      var location = await invisible.location;
      expect(location, isPoint);
      expect(location.x, 0);
      expect(location.y, 0);
    });

    test('size -- table', () async {
      var size = await table.size;
      expect(size, isSize);
      expect(size.width, isNonNegative);
      expect(size.height, isNonNegative);
    });

    test('size -- invisible', () async {
      var size = await invisible.size;
      expect(size, isSize);
      // TODO(DrMarcII): I thought these should be 0
      expect(size.width, isNonNegative);
      expect(size.height, isNonNegative);
    });

    test('name', () async {
      expect(await table.name, 'table');
      expect(await button.name, 'button');
      expect(await form.name, 'form');
      expect(await textInput.name, 'input');
    });

    test('text', () async {
      expect(await table.text, 'r1c1 r1c2\nr2c1 r2c2');
      expect(await button.text, 'button');
      expect(await invisible.text, '');
    });

    test('findElement -- success', () async {
      var element = await table.findElement(new By.tagName('tr'));
      expect(element, isWebElement);
    });

    test('findElement -- failure', () async {
      try {
        await button.findElement(new By.tagName('tr'));
        throw 'Expected NoSuchElementException';
      } on NoSuchElementException {}
    });

    test('findElements -- 1 found', () async {
      var elements = await form
          .findElements(new By.cssSelector('input[type=text]'))
          .toList();
      expect(elements, hasLength(1));
      expect(elements, everyElement(isWebElement));
    });

    test('findElements -- 4 found', () async {
      var elements = await table.findElements(new By.tagName('td')).toList();
      expect(elements, hasLength(4));
      expect(elements, everyElement(isWebElement));
    });

    test('findElements -- 0 found', () async {
      var elements = await form.findElements(new By.tagName('td')).toList();
      expect(elements, isEmpty);
    });

    test('attributes', () async {
      expect(await table.attributes['id'], 'table1');
      expect(await table.attributes['non-standard'], 'a non standard attr');
      expect(await table.attributes['disabled'], isNull);
      expect(await disabled.attributes['disabled'], 'true');
    });

    test('cssProperties', () async {
      expect(await invisible.cssProperties['display'], 'none');
      expect(await invisible.cssProperties['background-color'],
          'rgba(255, 0, 0, 1)');
      expect(await invisible.cssProperties['direction'], 'ltr');
    });

    test('equals', () async {
      expect(await invisible.equals(disabled), isFalse);
      var element = await driver.findElement(new By.cssSelector('table'));
      expect(await element.equals(table), isTrue);
    });
  });
}
