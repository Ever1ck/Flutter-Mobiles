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
  createPersona(token, persona) async {
    ArgumentError.checkNotNull(persona, 'persona');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(persona.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{"Authorization": token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModelo.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  deletePersona(token, id) async {
    ArgumentError.checkNotNull(token, 'persona');
    ArgumentError.checkNotNull(id, '0');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{"Authorization": token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModelo.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getPersona(token) async {
    final prefs = await SharedPreferences.getInstance();
//var tokenx = prefs.getString("token");
    ArgumentError.checkNotNull(token, "token");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{"Authorization": token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
/*var value = _result.data.map((dynamic i) =>
PersonaModelo.fromJson(i as Map<String, dynamic>))
.toList();*/
    var value = ResponseModelo.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updatePersona(token, id, persona) async {
    ArgumentError.checkNotNull(id, '0');
    ArgumentError.checkNotNull(persona, 'persona');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(persona.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/persona/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{"Authorization": token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModelo.fromJson(_result.data);
    return Future.value(value);
  }
}
