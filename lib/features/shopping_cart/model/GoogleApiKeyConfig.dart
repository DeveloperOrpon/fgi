class GoogleApiKeyConfig {
  final String android;
  final String ios;
  final String web;
  final String? lightStyleJson;
  final String? darkStyleJson;
  final String? lightStyleUrl;
  final String? darkStyleUrl;

  const GoogleApiKeyConfig({
    required this.android,
    required this.ios,
    required this.web,
    this.lightStyleJson,
    this.darkStyleJson,
    this.lightStyleUrl,
    this.darkStyleUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is GoogleApiKeyConfig &&
              runtimeType == other.runtimeType &&
              android == other.android &&
              ios == other.ios &&
              web == other.web);

  @override
  int get hashCode => android.hashCode ^ ios.hashCode ^ web.hashCode;

  bool get isEmpty => android.isEmpty && ios.isEmpty && web.isEmpty;

  bool get isNotEmpty => !isEmpty;

  @override
  String toString() {
    return 'GoogleApiKeyConfig{ android: $android, ios: $ios, web: $web }';
  }

  GoogleApiKeyConfig copyWith({
    String? android,
    String? ios,
    String? web,
    String? lightStyleJson,
    String? darkStyleJson,
    String? lightStyleUrl,
    String? darkStyleUrl,
  }) {
    return GoogleApiKeyConfig(
      android: android ?? this.android,
      ios: ios ?? this.ios,
      web: web ?? this.web,
      lightStyleJson: lightStyleJson ?? this.lightStyleJson,
      darkStyleJson: darkStyleJson ?? this.darkStyleJson,
      lightStyleUrl: lightStyleUrl ?? this.lightStyleUrl,
      darkStyleUrl: darkStyleUrl ?? this.darkStyleUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'android': android,
      'ios': ios,
      'web': web,
      'lightStyleJson': lightStyleJson,
      'darkStyleJson': darkStyleJson,
      'lightStyleUrl': lightStyleUrl,
      'darkStyleUrl': darkStyleUrl,
    };
  }

  factory GoogleApiKeyConfig.fromMap(Map map) {
    return GoogleApiKeyConfig(
      android: '${map['android']}',
      ios: '${map['ios']}',
      web: '${map['web']}',
      lightStyleJson: map['lightStyleJson'],
      darkStyleJson: map['darkStyleJson'],
      lightStyleUrl: map['lightStyleUrl'],
      darkStyleUrl: map['darkStyleUrl'],
    );
  }
}
