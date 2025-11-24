import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/person_profile_repository.dart';
import '../data/repositories/github_stats_repository.dart';
import '../data/repositories/appconfig/app_config_repository.dart';
import '../data/services/github_api_service.dart';
import '../main_viewmodel.dart';

List<SingleChildWidget> getProviders(
  PersonProfileRepository personProfileRepository,
  AppConfigRepository appConfigRepository,
) {
  return [
    Provider<PersonProfileRepository>.value(
      value: personProfileRepository,
    ),

    Provider<AppConfigRepository>.value(
      value: appConfigRepository,
    ),

    Provider<GithubApiService>(
      create: (_) => GithubApiService(),
    ),

    Provider<GithubStatsRepository>(
      create: (context) => GithubStatsRepository(
        apiService: context.read<GithubApiService>(),
      ),
    ),

    ChangeNotifierProvider<MainAppViewModel>(
      create: (context) => MainAppViewModel(
        context.read<AppConfigRepository>(),
      ),
    ),
  ];
}