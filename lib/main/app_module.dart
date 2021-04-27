import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mesa_news/data/cache/cache_secure_storage.dart';
import 'package:mesa_news/data/cache/cache_storage.dart';
import 'package:mesa_news/data/usercases/local_current_account.dart';
import 'package:mesa_news/data/usercases/remote_add_account.dart';
import 'package:mesa_news/domain/usercases/add_account.dart';
import 'package:mesa_news/domain/usercases/current_account.dart';
import 'package:mesa_news/infra/cache/local_storage_adapter.dart';
import 'package:mesa_news/ui/pages/feed/feed_page.dart';
import 'package:mesa_news/ui/pages/login/login_presenter.dart';
import 'package:mesa_news/ui/pages/login/sign_in_page.dart';
import 'package:mesa_news/ui/pages/sign_up/sign_up_page.dart';
import 'package:mesa_news/ui/pages/sign_up/sign_up_presenter.dart';

import '../data/http/http_client.dart';
import '../data/usercases/remote_authentication.dart';
import '../domain/usercases/authentication.dart';
import '../infra/http/base_data.dart';
import '../infra/http/http_adapter.dart';
import '../infra/cache/secure_storage_adapter.dart';
import '../presentation/protocols/validation.dart';
import '../presentation/presenters/modular_login_presenter.dart';
import '../presentation/presenters/modular_sign_up_presenter.dart';
import '../ui/pages/login/login_page.dart';
import '../validation/validators/validate_composite.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => Client()),
    Bind.factory<HttpClient>((i) => HttpAdapter(i.get<Client>())),
    Bind.factory<Authentication>(
        (i) => RemoteAuthentication(httpClient: i.get<HttpClient>(), url: makeApiUrl('signin'))),
    Bind.factory<Validation>((i) => ValidationComposite()),
    Bind.factory((i) => FlutterSecureStorage()),
    Bind.factory<CacheSecureStorage>((i) => SecureStorageAdapter(secureStorage: i.get())),
    Bind.factory<CacheStorage>((i) => LocalStorageAdapter()),
    Bind.factory<CurrentAccount>((i) => LocalCurrentAccount(cacheSecureStorage: i.get())),
    Bind.factory<AddAccount>((i) => RemoteAddAccount(httpClient: i.get(), url: makeApiUrl('signup'))),
    Bind.singleton<LoginPresenter>(
        (i) => ModularLoginController(validation: i.get(), authentication: i.get(), currentAccount: i.get())),
    Bind.singleton<SignUpPresenter>(
        (i) => ModularSignUpPresenter(validation: i.get(), addAccount: i.get(), currentAccount: i.get(), cacheStorage: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => LoginPage()),
    ChildRoute('/signIn', child: (_, __) => SignInPage()),
    ChildRoute('/signUp', child: (_, __) => SignUpPage()),
    ChildRoute('/feed', child: (_, __) => FeedPage()),
  ];
}
