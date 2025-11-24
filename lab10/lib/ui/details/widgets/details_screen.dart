import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../view_models/details_viewmodel.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsViewModel viewModel;

  const DetailsScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DetailsViewModel>(
        builder: (context, vm, child) {
          final profile = vm.profile;
          final titleText = "Навички: ${profile.name} ${profile.surname}";

          return Scaffold(
            appBar: AppBar(
              title: Text(titleText),
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildSkillsList(vm),
                ),
                _buildGithubStats(context, vm),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillsList(DetailsViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: vm.profile.skills.length,
      itemBuilder: (context, index) {
        final skill = vm.profile.skills[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.1),
              child: Text(
                "${index + 1}",
                style: const TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
            title: Text(skill.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(skill.description),
          ),
        );
      },
    );
  }

  Widget _buildGithubStats(BuildContext context, DetailsViewModel vm) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Center(
            child: _buildStatsContent(context, vm),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsContent(BuildContext context, DetailsViewModel vm) {
    if (vm.isLoadingStats) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Завантажую статистику..."),
        ],
      );
    }

    if (vm.statsError != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 10),
          Text(
            "Не вдалося завантажити статистику",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            vm.statsError!,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    if (vm.stats != null) {
      final stats = vm.stats!;
      return Column(
        children: [
          Text(
            "GitHub: ${vm.profile.githubUsername}",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn("Репозиторії", stats.publicRepos.toString()),
              _buildStatColumn("Підписники", stats.followers.toString()),
              _buildStatColumn("Стежить", stats.following.toString()),
            ],
          ),
        ],
      );
    }
    return const SizedBox.shrink(); 
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
