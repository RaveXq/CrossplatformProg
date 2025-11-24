import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../ui/details/view_models/details_viewmodel.dart';
import '../ui/details/widgets/details_screen.dart';
import '../ui/home/view_models/home_viewmodel.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/edit_profile/view_models/edit_profile_viewmodel.dart';
import '../ui/edit_profile/widgets/edit_profile_screen.dart';
import 'routes.dart';
import '../data/repositories/person_profile_repository.dart';

GoRouter createRouter() => GoRouter(
      initialLocation: MyRoutes.home,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: MyRoutes.home,
          builder: (context, state) {
            final viewModel = HomeViewModel(
              profileRepository: context.read(),
            );
            return HomeScreen(viewModel: viewModel);
          },
          routes: [
            GoRoute(
              path: '${MyRoutes.details}/:id',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                final viewModel = DetailsViewModel(
                  profileRepository: context.read(),
                  statsRepository: context.read(),
                );
                viewModel.loadProfile(id);
                return DetailsScreen(viewModel: viewModel);
              },
            ),
          ],
        ),
        GoRoute(
          path: MyRoutes.createProfile,
          builder: (context, state) {
            final viewModel = EditProfileViewModel(
              profileRepository: context.read(),
            );
            viewModel.loadProfile(null);
            return EditProfileScreen(viewModel: viewModel);
          },
        ),
        GoRoute(
          path: '${MyRoutes.editProfile}/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final profile = context.read<PersonProfileRepository>().getProfileById(id);
            final viewModel = EditProfileViewModel(
              profileRepository: context.read(),
            );
            viewModel.loadProfile(profile);
            return EditProfileScreen(viewModel: viewModel);
          },
        ),
        GoRoute(
          path: '${MyRoutes.duplicateProfile}/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final profile = context.read<PersonProfileRepository>().getProfileById(id);

            final duplicatedProfile = profile.copyWith(
              surname: '${profile.surname} (копія)',
            );

            final viewModel = EditProfileViewModel(
              profileRepository: context.read(),
            );
            viewModel.loadProfile(duplicatedProfile, isDuplicating: true);
            return EditProfileScreen(viewModel: viewModel);
          },
        ),
      ],
    );