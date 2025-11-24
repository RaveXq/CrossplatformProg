import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../routing/routes.dart';
import '../view_models/home_viewmodel.dart';
import '../../../domain/models/person_profile.dart';
import '../../../main_viewmodel.dart';
import '../../common/widgets/banner_ad_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Профілі резюме"),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          actions: [
            Consumer<MainAppViewModel>(
              builder: (context, themeViewModel, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: IconButton(
                    icon: Icon(
                      themeViewModel.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    onPressed: () {
                      themeViewModel.toggleTheme();
                    },
                    tooltip: themeViewModel.isDarkMode
                        ? 'Світла тема'
                        : 'Темна тема',
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                Expanded(
                  child: _buildProfileList(context, vm.profiles),
                ),
                MyBannerAdWidget(),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.push(MyRoutes.createProfile);
            viewModel.loadProfiles(); 
          },
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildProfileList(BuildContext context, List<PersonProfile> profiles) {
    final vm = Provider.of<HomeViewModel>(context, listen: false);
    
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent.withOpacity(0.1),
              child: Text(
                profile.name.isNotEmpty ? profile.name.substring(0, 1) : "?",
                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text("${profile.name} ${profile.surname}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(profile.bio),
            onTap: () {
              context.push(MyRoutes.detailsPath(profile.id));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.blueGrey),
                  tooltip: "Дублювати",
                  onPressed: () async {
                    await context.push(MyRoutes.duplicateProfilePath(profile.id));
                    vm.loadProfiles();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                  tooltip: "Редагувати",
                  onPressed: () async {
                    await context.push(MyRoutes.editProfilePath(profile.id));
                    vm.loadProfiles();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}