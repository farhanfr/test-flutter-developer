import 'package:flutter_dotenv/flutter_dotenv.dart';

String BASE_URL = "${dotenv.env['BASE_URL']}/3";
String API_KEY = "${dotenv.env['API_KEY']}"; 
String IMAGE_LINK = "https://image.tmdb.org/t/p/original";