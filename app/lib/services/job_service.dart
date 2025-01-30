import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/job.dart';

class JobService {
  final String baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';

  Future<List<Job>> searchJobs(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/jobs/search?query=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jobsJson = json.decode(response.body);
        return jobsJson.map((job) => Job.fromJson(job)).toList();
      } else {
        throw Exception(
            'Failed to load jobs: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching jobs: $e'); // Log para debug
      throw Exception('Failed to load jobs: $e');
    }
  }
}
