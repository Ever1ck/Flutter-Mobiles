part of 'persona_api.dart';

class _PersonaApi implements PersonaApi {
  _PersonaApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= UrlApi.urlApix;
  }
  final Dio _dio;
  String baseUrl;
  @override
  login(user) async {
    ArgumentError.checkNotNull(user, "user");
    print("ver: ${user.toJson()}");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/auth/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = TokenModelo.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  Future<ResponseModelo> createPersona(String token, PersonaModelo persona) {
    // TODO: implement createPersona
    throw UnimplementedError();
  }

  @override
  Future<ResponseModelo> deletePersona(String token, int id) {
    // TODO: implement deletePersona
    throw UnimplementedError();
  }

  @override
  Future<ResponseModelo> getPersona(String token) {
    // TODO: implement getPersona
    throw UnimplementedError();
  }

  @override
  Future<ResponseModelo> updatePersona(
      String token, int id, PersonaModelo persona) {
    // TODO: implement updatePersona
    throw UnimplementedError();
  }
}
