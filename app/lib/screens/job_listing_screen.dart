import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import 'job_details_screen.dart';

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({Key? key}) : super(key: key);

  @override
  _JobListingScreenState createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  final JobService _jobService = JobService();
  List<Job> _jobs = [];
  String _searchQuery = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchJobs();
  }

  Future<void> _searchJobs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final jobs = await _jobService.searchJobs(_searchQuery);
      setState(() {
        _jobs = jobs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load jobs: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca de Emprego'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Procurar vagas de emprego',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              onSubmitted: (_) => _searchJobs(),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      final job = _jobs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(job.title),
                          subtitle: Text('${job.company} - ${job.location}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(job: job),
                                ),
                              );
                            },
                            child: const Text('Detalhes'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
