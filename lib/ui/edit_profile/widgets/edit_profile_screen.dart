import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../view_models/edit_profile_viewmodel.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileViewModel viewModel;

  const EditProfileScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<EditProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(vm.pageTitle),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      await vm.saveProfile();
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(vm.nameController, "Ім'я"),
                  const SizedBox(height: 16),
                  _buildTextField(vm.surnameController, "Прізвище"),
                  const SizedBox(height: 16),
                  _buildTextField(vm.bioController, "Біо (посада)"),
                  const SizedBox(height: 16),
                  _buildTextField(vm.githubController, "Ім'я на GitHub"),
                  const SizedBox(height: 24),
                  Text("Навички", style: Theme.of(context).textTheme.titleLarge),
                  _buildSkillsSection(context, vm),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, EditProfileViewModel vm) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildTextField(vm.skillNameController, "Назва навички"),
        const SizedBox(height: 16),
        _buildTextField(vm.skillDescController, "Опис навички"),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: vm.addSkill,
          child: const Text("Додати навичку"),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.skills.length,
          itemBuilder: (context, index) {
            final skill = vm.skills[index];
            return Card(
              child: ListTile(
                title: Text(skill.name),
                subtitle: Text(skill.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => vm.removeSkill(index),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}