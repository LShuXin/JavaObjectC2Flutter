import 'dart:io';

class MyHttpClient implements HttpClient {
    final HttpClient _realClient;

    MyHttpClient(this._realClient);

    @override
    bool get autoUncompress => _realClient.autoUncompress;

    @override
    set autoUncompress(bool value) => _realClient.autoUncompress = value;

    @override
    Duration? get connectionTimeout => _realClient.connectionTimeout;

    @override
    set connectionTimeout(Duration? value) => _realClient.connectionTimeout = value;

    @override
    Duration get idleTimeout => _realClient.idleTimeout;

    @override
    set idleTimeout(Duration value) => _realClient.idleTimeout = value;

    @override
    int? get maxConnectionsPerHost => _realClient.maxConnectionsPerHost;

    @override
    set maxConnectionsPerHost(int? value) => _realClient.maxConnectionsPerHost = value;

    @override
    String? get userAgent => _realClient.userAgent;

    @override
    set userAgent(String? value) => _realClient.userAgent = value;

    @override
    void addCredentials(Uri url, String realm, HttpClientCredentials credentials) => _realClient.addCredentials(url, realm, credentials);

    @override
    void addProxyCredentials(String host, int port, String realm, HttpClientCredentials credentials) => _realClient.addProxyCredentials(host, port, realm, credentials);

    @override
    set authenticate(Future<bool> Function(Uri url, String scheme, String? realm)? f) => _realClient.authenticate = f;

    @override
    set authenticateProxy(Future<bool> Function(String host, int port, String scheme, String? realm)? f) => _realClient.authenticateProxy = f;

    @override
    set badCertificateCallback(bool Function(X509Certificate cert, String host, int port)? callback) => _realClient.badCertificateCallback = callback;

    @override
    void close({bool force = false}) => _realClient.close(force: force);

    @override
    Future<HttpClientRequest> delete(String host, int port, String path) => _realClient.delete(host, port, path);

    @override
    Future<HttpClientRequest> deleteUrl(Uri url) => _realClient.deleteUrl(url);

    @override
    set findProxy(String Function(Uri url)? f) => _realClient.findProxy = f;

    @override
    Future<HttpClientRequest> get(String host, int port, String path) => _realClient.get(host, port, path);

    @override
    Future<HttpClientRequest> getUrl(Uri url) => _realClient.getUrl(url);

    @override
    Future<HttpClientRequest> head(String host, int port, String path) => _realClient.head(host, port, path);

    @override
    Future<HttpClientRequest> headUrl(Uri url) => _realClient.headUrl(url);

    @override
    Future<HttpClientRequest> open(String method, String host, int port, String path) => _realClient.open(method, host, port, path);

    @override
    Future<HttpClientRequest> openUrl(String method, Uri url) => _realClient.openUrl(method, url);

    @override
    Future<HttpClientRequest> patch(String host, int port, String path) => _realClient.patch(host, port, path);

    @override
    Future<HttpClientRequest> patchUrl(Uri url) => _realClient.patchUrl(url);

    @override
    Future<HttpClientRequest> post(String host, int port, String path) => _realClient.post(host, port, path);

    @override
    Future<HttpClientRequest> postUrl(Uri url) => _realClient.postUrl(url);

    @override
    Future<HttpClientRequest> put(String host, int port, String path) => _realClient.put(host, port, path);

    @override
    Future<HttpClientRequest> putUrl(Uri url) => _realClient.putUrl(url);
}

class MyHttpOverrides extends HttpOverrides {
    MyHttpOverrides();

    @override
    HttpClient createHttpClient(SecurityContext? context) {
        HttpClient cli = MyHttpClient(
            super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true
        );
        cli.userAgent = 'Mozilla/5.0';
        cli.findProxy = null;
        return cli;
    }
}
