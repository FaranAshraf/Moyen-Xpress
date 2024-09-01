import '../../../resources/exports/index.dart';

class AuthManager extends GetxController with CacheManager {
  static AuthManager instance = Get.find();

  late Rx<Session?> session = Rxn<Session>();

  RxBool rememberCredentials = true.obs;

  final RxBool _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;

  String get token => session.value!.tokenID!;

  User? get user => session.value?.user;

  Future<bool> checkLoginStatus() async {
    try {
      final token = getToken();

      if (token != null) {
        rememberCredentials.value = true;

        _isLoggedIn.value = true;

        session.value = getSessionData();
        return _isLoggedIn.value;
      } else {
        session.value = Session();
      }
      return false;
    } catch (e) {
      log.e(e);
      removeCredentials();
    }
    return false;
  }

  Future<void> removeCredentials() async {
    _isLoggedIn.value = false;
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.erase();
  }

  // To avoid multiple Kick out messages
  int? lastResponseStatusCode;

  Future<void> login(Session? session) async {
    _isLoggedIn.value = true;
    if (rememberCredentials.value) await saveToken(session?.tokenID);
    await saveCurrentSession(session: session);
  }

  Future<void> saveCurrentSession({
    Object? id,
    User? user,
    Session? session,
  }) async {
    if (session != null) this.session.value = session;
    this.session.update((session) {
      if (user != null) session!.user = user;
    });
    if (rememberCredentials.value) await saveSession(this.session.value);
  }

  // Update Session from Here
  Future<void> updateSession({
    Object? id,
    User? user,
    Session? session,
  }) async {
    if (session != null) this.session.value = session;

    this.session.update((session) {
      if (user != null) session!.user = user;
    });

    if (id is List) {
      update((id as List<Object>?) ?? [Strings.UPDATE_AUTH_SESSION]);
    } else {
      update([id ?? Strings.UPDATE_AUTH_SESSION]);
    }
  }

  // Add new store and change default store
  Future<void> addNewStore({
    Object? id,
    Session? session,
  }) async {
    if (session != null) this.session.value = session;

    if (id is List) {
      update((id as List<Object>?) ?? [Strings.UPDATE_AUTH_SESSION]);
    } else {
      update([id ?? Strings.UPDATE_AUTH_SESSION]);
    }
  }

  Future<void> clearCacheImages({String? url}) async {
    imageCache.clear();
    imageCache.clearLiveImages();
    await CachedNetworkImage.evictFromCache(
      url ?? AuthManager.instance.user?.photo ?? '',
    );
  }
}

mixin CacheManager {
  static const key = 'AUXSJD029SKJS10293LATXAU';
  static const iv = 'ZXeU36GNM+y57MBS1M+NUA==';

  String? getToken() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.token.toString());
  }

  Future<bool> saveToken(String? token) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.token.toString(), token);
    return true;
  }

  Future<bool> saveSession(Session? session) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.sessionData.toString(), session!.toJson());
    log.e("SAVING SESSION : ${session.toJson()}");
    return true;
  }

  Session? getSessionData() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    log.w(
        "RESTORE SESSION : ${Session.fromJson(box.read(CacheManagerKeys.sessionData.toString())).toJson()}");
    return Session.fromJson(box.read(CacheManagerKeys.sessionData.toString()));
  }
}

enum CacheManagerKeys { token, email, pass, sessionData }
