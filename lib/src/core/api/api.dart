import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String kBaseUrl = 'https://gateway.marvel.com/v1/public';

String kApiKey = dotenv.env["API_KEY"]!;
String kPrivateApiKey = dotenv.env["API_PRIVATE_KEY"]!;

int timeStamp = DateTime.now().millisecondsSinceEpoch;

String generateMd5() {
  return md5.convert(utf8.encode("$timeStamp$kPrivateApiKey$kApiKey")).toString();
}

final BaseOptions kBaseClientOptions = BaseOptions(
  baseUrl: kBaseUrl,
  queryParameters: {
    "apikey": kApiKey,
    "ts": timeStamp,
    "hash": generateMd5(),
  },
  contentType: 'application/json;charset=utf-8',
);
