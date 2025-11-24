abstract final class MyRoutes {
  static const home = '/';
  static const details = 'details';

  static String detailsPath(int id) => '/details/$id';

  static const createProfile = '/create';
  static const editProfile = '/edit';
  static const duplicateProfile = '/duplicate';

  static String editProfilePath(int id) => '/edit/$id';
  static String duplicateProfilePath(int id) => '/duplicate/$id';
}