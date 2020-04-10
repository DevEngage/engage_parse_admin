import 'dart:convert';
// import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:http/http.dart';
// import 'dart:io' ;
// import 'dart:html' as html;

class EngageParseFile extends ParseObject {
  String base64;
  Uint8List bytes;
  String _path;
  String _ext;
  bool _debug;
  ParseHTTPClient _client;
  EngageParseFile({
    this.base64,
    this.bytes,
    ext,
    name,
    debug,
    ParseHTTPClient client,
    bool autoSendSessionId,
  }) : super('ParseFile', debug: debug, autoSendSessionId: autoSendSessionId) {
    _path = '/files/$name';
    _client = ParseHTTPClient(
        sendSessionId: ParseCoreData().autoSendSessionId,
        securityContext: ParseCoreData().securityContext);
    _debug = isDebugEnabled(objectLevelDebug: debug);
    _ext = ext;
    // if (file != null) {
    //   name = path.basename(file.path);
    //   _path = '/files/$name';
    // } else {
    name = name;
    url = url;
    // }
  }

  String get name => super.get<String>(keyVarName);
  set name(String name) => set<String>(keyVarName, name);

  String get url => super.get<String>(keyVarURL);
  set url(String url) => set<String>(keyVarURL, url);

  bool get saved => url != null;

  @override
  Map<String, dynamic> toJson({bool full = false, bool forApiRQ = false}) =>
      <String, String>{'__type': keyFile, 'name': name, 'url': url};

  @override
  String toString() => json.encode(toJson(full: true));

  Future<ParseFile> loadStorage() async {
    //   final Directory tempPath = await getTemporaryDirectory();

    //   if (name == null) {
    //     file = null;
    //     return this;
    //   }

    //   final File possibleFile = File('${tempPath.path}/$name');
    //   // ignore: avoid_slow_async_io
    //   final bool exists = await possibleFile.exists();

    //   if (exists) {
    //     file = possibleFile;
    //   } else {
    //     file = null;
    //   }

    //   return this;
    return null;
  }

  // Future<EngageParseFile> download() async {
  //   if (url == null) {
  //     return this;
  //   }

  //   html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  //   anchorElement.download = url;
  //   anchorElement.click();

  //   return this;
  // }

  /// Uploads a file to Parse Server
  @override
  Future<ParseResponse> save() async {
    return upload();
  }

  /// Uploads a file to Parse Server
  Future<ParseResponse> upload() async {
    if (saved) {
      //Creates a Fake Response to return the correct result
      final Map<String, String> response = <String, String>{
        'url': url,
        'name': name
      };
      return handleResponse<ParseFile>(
          this,
          Response(json.encode(response), 201),
          ParseApiRQ.upload,
          _debug,
          parseClassName);
    }

    final String ext = _ext ?? path.extension(name).replaceAll('.', '');
    final Map<String, String> headers = <String, String>{
      "content-type": getContentType(ext) // HttpHeaders.contentTypeHeader
    };
    try {
      final String uri = _client.data.serverUrl + '$_path';
      List<int> body;
      if (base64 != null) {
        body = base64Decode(base64);
      } else if (bytes != null) {
        body = bytes;
      }
      final Response response =
          await _client.post(uri, headers: headers, body: body);
      if (response.statusCode == 201) {
        final Map<String, dynamic> map = json.decode(response.body);
        url = map['url'].toString();
        name = map['name'].toString();
      }
      return handleResponse<ParseFile>(
          this, response, ParseApiRQ.upload, _debug, parseClassName);
    } on Exception catch (e) {
      return handleException(e, ParseApiRQ.upload, _debug, parseClassName);
    }
  }
}
