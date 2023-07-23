abstract class BaseApiService {
  Future getGetApiResponse(String url, [Map<String, dynamic>? headers]);
  Future getPostApiResponse(String url, dynamic data);
}
