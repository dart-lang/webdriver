part of webdriver_test;

class MouseTest {
  main() {

    io.File file = new io.File('test_page.html');

    group('Mouse', () {

      WebDriver driver;
      WebElement button;

      setUp(() {
        return WebDriver.createDriver()
            .then((_driver) => driver = _driver)
            .then((_) => driver.get('file://' + file.fullPathSync()))
            .then((_) => driver.findElement(new By.tagName('button')))
            .then((_e) => button = _e);
      });

      tearDown(() => driver.quit());

      test('moveTo element/click', () {
        return driver.mouse.moveTo(element: button)
            .click()
            .then((_) => driver.switchTo.alert)
            .then((alert) => alert.dismiss);
      });

      test('moveTo coordinates/click', () {
        return button.location
            .then((pos) => driver.mouse
                .moveTo(xOffset: pos.x + 5, yOffset: pos.y + 5)
                .click())
            .then((_) => driver.switchTo.alert)
            .then((alert) => alert.dismiss);
      });

      test('moveTo element coordinates/click', () {
        return driver.mouse.moveTo(element: button, xOffset: 5, yOffset: 5)
            .click()
            .then((_) => driver.switchTo.alert)
            .then((alert) => alert.dismiss);
      });

      // TODO(DrMarcII): Better up/down tests
      test('down/up', () {
        return driver.mouse.moveTo(element: button)
            .down()
            .up()
            .then((_) => driver.switchTo.alert)
            .then((alert) => alert.dismiss);
      });

      // TODO(DrMarcII): Better double click test
      test('doubleClick', () {
        return driver.mouse.moveTo(element: button)
            .doubleClick()
            .then((_) => driver.switchTo.alert)
            .then((alert) => alert.dismiss);
      });
    });
  }
}
