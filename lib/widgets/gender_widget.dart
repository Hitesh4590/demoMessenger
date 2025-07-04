import 'package:flutter/material.dart';

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}

class GenderDropdown extends StatelessWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;

  const GenderDropdown({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(
        labelText: 'Select Gender',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      value: selectedGender,
      items: Gender.values.map((gender) {
        return DropdownMenuItem<Gender>(
          value: gender,
          child: Text(gender.label),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}
