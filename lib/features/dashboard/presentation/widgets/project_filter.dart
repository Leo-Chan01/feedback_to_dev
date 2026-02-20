import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:flutter/material.dart';

class ProjectFilter extends StatelessWidget {
  const ProjectFilter({
    required this.projects, required this.selectedProject, required this.onProjectSelected, super.key,
  });

  final List<String> projects;
  final String selectedProject;
  final void Function(String) onProjectSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your Projects',
            style: 16.w600.copyWith(color: AppColors.yfdWhite),
          ),
        ),
        12.vertSpacing,
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: projects.length,
            separatorBuilder: (context, index) => 12.horizSpacing,
            itemBuilder: (context, index) {
              final project = projects[index];
              final isSelected = project == selectedProject;
              return GestureDetector(
                onTap: () => onProjectSelected(project),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yfdPrimary
                        : AppColors.yfdGrey05,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.yfdPrimary
                          : AppColors.yfdGrey04,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      project,
                      style: 12.w500.copyWith(
                        color: isSelected
                            ? AppColors.yfdWhite
                            : AppColors.yfdLightGrey08,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
