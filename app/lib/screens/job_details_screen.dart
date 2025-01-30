import 'package:flutter/material.dart';
import '../models/job.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              job.company,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              job.location,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'Job Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(job.description ?? 'No description available.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement apply for job functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Application submitted!')),
                );
              },
              child: const Text('Apply for this job'),
            ),
          ],
        ),
      ),
    );
  }
}
