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

  String get home {
    return _translations['home'] ?? 'Inicio';
  }

  String get search {
    return _translations['search'] ?? 'Buscar';
  }

  String get download {
    return _translations['download'] ?? 'Descarga';
  }

  String get darckMode {
    return _translations['darck_mode'] ?? 'Modo Oscuro';
  }

  String get viewMode {
    return _translations['view_mode'] ?? 'Capitulos en cascada';
  }

  String get language {
    return _translations['language'] ?? 'Idioma';
  }
}
