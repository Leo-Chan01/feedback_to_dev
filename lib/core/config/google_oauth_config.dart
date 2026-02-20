class GoogleOAuthConfig {
  static String iosClientId({required bool isDev}) =>
      isDev ? _iosClientIdDev : _iosClientIdProd;

  static String androidServerClientId({required bool isDev}) =>
      isDev ? _androidServerClientIdDev : _androidServerClientIdProd;

  static String iosClientIdForFlavor(String flavor) {
    switch (flavor) {
      case 'development':
        return _iosClientIdDev;
      case 'staging':
        return _iosClientIdStg;
      case 'production':
      default:
        return _iosClientIdProd;
    }
  }

  static String androidServerClientIdForFlavor(String flavor) {
    switch (flavor) {
      case 'development':
        return _androidServerClientIdDev;
      case 'staging':
        return _androidServerClientIdStg;
      case 'production':
      default:
        return _androidServerClientIdProd;
    }
  }

  static const String _iosClientIdDev =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';
  static const String _androidServerClientIdDev =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';

  static const String _iosClientIdStg =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';
  static const String _androidServerClientIdStg =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';

  static const String _iosClientIdProd =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';
  static const String _androidServerClientIdProd =
      '1034519698741-vndck3d2fmalnsfb2n56a1bk5h7k6kcn.apps'
      '.googleusercontent.com';
}
