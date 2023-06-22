abstract class IHttpService {
  Future<Map<String, dynamic>> getResponse(String path);
  Future<List<dynamic>> getListResponse(String path);

  Future<Map<String, dynamic>> post(String path, dynamic body);
}
