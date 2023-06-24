abstract class IHttpService {
  Future<Map<String, dynamic>> get(String path);
  Future<List<dynamic>> getListResponse(String path);

  Future<Map<String, dynamic>> post(String path, dynamic body);

  Future<Map<String, dynamic>> put(String path, dynamic body);
}
