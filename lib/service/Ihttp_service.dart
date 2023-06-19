abstract class IHttpService {
  Future<Map<String, dynamic>> getResponse(String path);

  Future<List<Map<String, dynamic>>> getListResponse(String path);
}
