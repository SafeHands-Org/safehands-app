import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';

class EditableDropdownField extends StatelessWidget {
  const EditableDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validator,
    required this.hintText,
  });

  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(hintText ?? ''),
          onChanged: onChanged,
          validator: validator,
          items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: cs.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class EditableFormField extends StatelessWidget {
  const EditableFormField({
    super.key,
    required this.ctrl,
    required this.validators,
    required this.hintText,
  });

  final TextEditingController ctrl;
  final String? Function(String?) validators;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          validator: validators,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: cs.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.borderRadiusXl,
              borderSide: BorderSide(color: cs.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: cs.onSurface, letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

InputDecoration formFieldDecoration({
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  required BuildContext context,
}) {
  final cs = Theme.of(context).colorScheme;

  final border = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant),
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant, width: 2),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.error),
  );

  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: cs.onSurface, fontSize: 14),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: cs.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: border,
    enabledBorder: border,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: errorBorder,
  );
}


InputDecorationTheme formFieldDecorationTheme(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  final border = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant),
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.outlineVariant, width: 2),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: AppRadius.borderRadiusMd,
    borderSide: BorderSide(color: cs.error),
  );

  return InputDecorationTheme(
    hintStyle: TextStyle(color: cs.onSurface, fontSize: 14),
    filled: true,
    fillColor: cs.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: border,
    enabledBorder: border,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: errorBorder,
  );
}

class OptionalFormField extends StatelessWidget {
  const OptionalFormField({
    super.key,
    required this.controller,
    required this.options,
    this.onSelected,
    this.hintText,
    this.validator
  });

  final TextEditingController controller;
  final List<String> options;
  final ValueChanged<String>? onSelected;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        final query = textEditingValue.text.trim().toLowerCase();

        if (query.isEmpty) return options;

        return options.where(
          (option) => option.toLowerCase().contains(query),
        );
      },

      onSelected: (value) {
        controller.text = value;
        onSelected?.call(value);
      },

      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) {
        textEditingController.text = controller.text;
        textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        );

        textEditingController.addListener(() {
          controller.value = textEditingController.value;
        });

        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          validator: validator,
          decoration: formFieldDecoration(
            context: context,
            hintText: hintText,
          ),
        );
      },

      optionsViewBuilder: (context, onSelected, filteredOptions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: AppRadius.borderRadiusMd,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 240,
                minWidth: 300,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  final option = filteredOptions.elementAt(index);

                  return ListTile(
                    title: Text(option),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}