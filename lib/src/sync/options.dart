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

import 'common.dart';

class Cookies extends WebDriverBase {
  Cookies(driver) : super(driver, 'cookie');

  /// Set a cookie.
  void add(Cookie cookie) {
    post('', {'cookie': cookie});
  }

  /// Delete the cookie with the given [name].
  void delete(String name) {
    delete('$name');
  }

  /// Delete all cookies visible to the current page.
  void deleteAll() {
    delete('');
  }

  /// Retrieve all cookies visible to the current page.
  List<Cookie> get all {
    var cookies = get('') as List<Map<String, dynamic>>;
    return cookies.map((c) => new Cookie.fromJson(c)).toList();

  }

  @override
  String toString() => '$driver.cookies';

  @override
  int get hashCode => driver.hashCode;

  @override
  bool operator ==(other) => other is Cookies && other.driver == driver;
}

class Cookie {
  /// The name of the cookie.
  final String name;

  /// The cookie value.
  final String value;

  /// (Optional) The cookie path.
  final String path;

  /// (Optional) The domain the cookie is visible to.
  final String domain;

  /// (Optional) Whether the cookie is a secure cookie.
  final bool secure;

  /// (Optional) When the cookie expires.
  final DateTime expiry;

  Cookie(this.name, this.value,
      {this.path, this.domain, this.secure, this.expiry});

  factory Cookie.fromJson(Map<String, dynamic> json) {
    var expiry;
    if (json['expiry'] is num) {
      expiry = new DateTime.fromMillisecondsSinceEpoch(
          json['expiry'].toInt() * 1000,
          isUtc: true);
    }
    return new Cookie(json['name'], json['value'],
        path: json['path'],
        domain: json['domain'],
        secure: json['secure'],
        expiry: expiry);
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{'name': name, 'value': value};
    if (path is String) {
      json['path'] = path;
    }
    if (domain is String) {
      json['domain'] = domain;
    }
    if (secure is bool) {
      json['secure'] = secure;
    }
    if (expiry is DateTime) {
      json['expiry'] = (expiry.millisecondsSinceEpoch / 1000).ceil();
    }
    return json;
  }

  @override
  String toString() => 'Cookie${toJson()}';
}

class Timeouts extends WebDriverBase {
  Timeouts(driver) : super(driver, 'timeouts');

  void _set(String type, Duration duration) {
    post('', {'type': type, 'ms': duration.inMilliseconds});
  }

  /// Set the script timeout.
  void setScriptTimeout(Duration duration) => _set('script', duration);

  /// Set the implicit timeout.
  void setImplicitTimeout(Duration duration) => _set('implicit', duration);

  /// Set the page load timeout.
  void setPageLoadTimeout(Duration duration) => _set('page load', duration);

  @override
  String toString() => '$driver.timeouts';

  @override
  int get hashCode => driver.hashCode;

  @override
  bool operator ==(other) => other is Timeouts && other.driver == driver;
}
