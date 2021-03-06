import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../data/cache/cache_secure_storage.dart';
import '../data/cache/cache_storage.dart';
import '../data/http/http_client.dart';
import '../data/usercases/local_current_account.dart';
import '../data/usercases/remote_add_account.dart';
import '../data/usercases/remote_authentication.dart';
import '../data/usercases/remote_load_posts.dart';
import '../domain/usercases/add_account.dart';
import '../domain/usercases/authentication.dart';
import '../domain/usercases/current_account.dart';
import '../domain/usercases/load_posts.dart';
import '../infra/cache/local_storage_adapter.dart';
import '../infra/cache/secure_storage_adapter.dart';
import '../infra/http/base_data.dart';
import '../infra/http/http_adapter.dart';
import '../presentation/presenters/modular_feed_presenter.dart';
import '../presentation/presenters/modular_login_presenter.dart';
import '../presentation/presenters/modular_sign_up_presenter.dart';
import '../presentation/protocols/validation.dart';
import '../ui/pages/feed/feed_page.dart';
import '../ui/pages/feed/feed_presenter.dart';
import '../ui/pages/feed/filter/filter_page.dart';
import '../ui/pages/feed/news/news_page.dart';
import '../ui/pages/login/login_page.dart';
import '../ui/pages/login/login_presenter.dart';
import '../ui/pages/login/sign_in_page.dart';
import '../ui/pages/sign_up/sign_up_page.dart';
import '../ui/pages/sign_up/sign_up_presenter.dart';
import '../validation/validators/validate_composite.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Remote
    Bind.factory((i) => Client()),
    Bind.factory<HttpClient>((i) => HttpAdapter(i.get<Client>())),
    Bind.factory<Validation>((i) => ValidationComposite()),
    Bind.factory<Authentication>(
        (i) => RemoteAuthentication(httpClient: i.get<HttpClient>(), url: makeApiAuthUrl('signin'))),
    Bind.factory<AddAccount>((i) => RemoteAddAccount(httpClient: i.get(), url: makeApiAuthUrl('signup'))),
    Bind.factory<LoadPosts>((i) => RemoteLoadPosts(httpClient: i.get(), cacheSecureStorage: i.get())),

    // Local
    Bind.factory((i) => FlutterSecureStorage()),
    Bind.factory<CacheStorage>((i) => LocalStorageAdapter()),
    Bind.factory<CacheSecureStorage>((i) => SecureStorageAdapter(secureStorage: i.get())),
    Bind.factory<CurrentAccount>((i) => LocalCurrentAccount(cacheSecureStorage: i.get())),

    // presenters
    Bind.singleton<LoginPresenter>(
        (i) => ModularLoginController(validation: i.get(), authentication: i.get(), currentAccount: i.get())),
    Bind.singleton<SignUpPresenter>((i) => ModularSignUpPresenter(
        validation: i.get(), addAccount: i.get(), currentAccount: i.get(), cacheStorage: i.get())),
    Bind.singleton<FeedPresenter>((i) => ModularFeedPresenter(loadPosts: i.get<LoadPosts>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => LoginPage()),
    ChildRoute('/signIn', child: (_, __) => SignInPage()),
    ChildRoute('/signUp', child: (_, __) => SignUpPage()),
    ChildRoute('/feed', child: (_, __) => FeedPage()),
    ChildRoute('/news', child: (_, __) => NewsPage()),
    ChildRoute('/filter', child: (_, __) => FilterPage()),
  ];
}
