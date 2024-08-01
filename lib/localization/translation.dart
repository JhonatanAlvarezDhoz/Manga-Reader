class Translation {
  final Map<String, String> _translations;

  Translation(this._translations);

  String get userEmail {
    return _translations['user_email'] ?? 'Correo Electrónico';
  }

  String get somethingWentWrong {
    return _translations['something_went_wrong'] ??
        'Hubo un error. Por favor contactar con el administrador.';
  }

  String get somethingWentWrongLogin {
    return _translations['something_went_wrong_login'] ??
        'Hubo un error al iniciar sesión. Por favor contactar con el administrador.';
  }

  String get settings {
    return _translations['settings'] ?? 'Ajustes';
  }

  String get darckMode {
    return _translations['darck_mode'] ?? 'Modo Oscuro';
  }
}
