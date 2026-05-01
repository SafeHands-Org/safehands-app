// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/medications/widgets/medication_form_helpers.dart';
import 'package:frontend/services/api/models/medication/medication_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:frontend/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class MedicationFormView extends ConsumerStatefulWidget {
  const MedicationFormView({super.key});

  @override
  ConsumerState<MedicationFormView> createState() => _MedicationFormViewState();
}

class _MedicationFormViewState extends ConsumerState<MedicationFormView> {
  final SearchController _rxNormController = SearchController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _doseFormController = TextEditingController();
  final TextEditingController _doseStrengthController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _rxcui;
  List<String>? _ingredientNames;
  bool _isSaving = false;

  String? _currentQuery;
  late Iterable<Widget> _lastOptions = const <Widget>[];
  late final Debounceable<List<Candidate>?, String> _debouncedSearch;

  Future<List<Candidate>?> _search(String query) async {
    _currentQuery = query;
    if (query.isEmpty) return const [];

    final uri = Uri.parse(
      'https://rxnav.nlm.nih.gov/REST/approximateTerm.json'
      '?maxEntries=10&term=${Uri.encodeComponent(query)}&option=1',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) return const [];
    if (_currentQuery != query) return null;
    _currentQuery = null;

    final Map<String, dynamic> json = jsonDecode(response.body);
    final List<dynamic> candidates = json['approximateGroup']?['candidate'] ?? [];

    final Set<Candidate> seen = {};
    for (final c in candidates) {
      final name = c['name'];
      final rxcui = c['rxcui'];
      if (c['rank'] == '1' && name != null && rxcui != null && c['source'] == 'RXNORM') {
        final candidate = await _getProperties(rxcui, name);
        if (candidate != null) seen.add(candidate);
      }
    }
    return seen.toList();
  }

  Future<Candidate?> _getProperties(String rxcui, String name) async {
    final uri = Uri.parse(
      'https://rxnav.nlm.nih.gov/REST/rxcui/${Uri.encodeComponent(rxcui)}/related.json?tty=BN+IN',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) return null;

    final Map<String, dynamic> json = jsonDecode(response.body);
    final List<dynamic> types = json['relatedGroup']?['conceptGroup'] ?? [];

    String brandName = '';
    List<String> ingredientNames = [];

    for (final group in types) {
      final String tty = group['tty'] ?? '';
      final List<dynamic> props = group['conceptProperties'] ?? [];
      for (final prop in props) {
        if (tty == 'BN') brandName = capitalized(prop['name']);
        if (tty == 'IN') ingredientNames.add(capitalized(prop['name']));
      }
    }
    return Candidate(brandName: brandName, ingredientNames: ingredientNames, rxNorm: rxcui);
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = debounce<List<Candidate>?, String>(_search);

    ref.listenManual(medicationsProvider, (previous, next) {
      if (!_isSaving) return;

      next.whenOrNull(
        data: (_) {
          if (!mounted) return;
          _isSaving = false;
          ref.invalidate(aggregateMembershipsProvider);
          ref.invalidate(aggregateMemberProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Created Medication'),
              duration: Duration(milliseconds: 800),
            ),
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            if (!mounted) return;
            context.canPop() ? context.pop() : context.go('/medications');
          });
        },
        error: (error, _) {
          if (!mounted) return;
          _isSaving = false;
          final message = switch (error) {
            ServerException() => 'Request timed out. Try again.',
            _ => 'Something went wrong. Please try again.',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: const Color(0xFFB62320),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _rxNormController.dispose();
    _medicationController.dispose();
    _doseFormController.dispose();
    _doseStrengthController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _createMedication() async {
    if (_formKey.currentState!.validate()) {
      _isSaving = true;
      await ref.read(medicationsProvider.notifier).createMedication(
        MedicationRequest(
          names: [_medicationController.text.trim(), ...?_ingredientNames],
          dosage: _doseStrengthController.text.trim(),
          doseForm: _doseFormController.text.trim(),
          instructions: _instructionsController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/medications'),
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Medication Form',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Container(
            width: double.infinity,
            height: 700,
            color: cs.surface,
            child: Column(
              children: [
                SectionHeader(title: 'Create a new medication'),
                Card(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
                    child: Column(
                      children: [
                        FormSection(
                          title: 'Medication Name',
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _medicationController,
                                  decoration: formFieldDecoration(context: context),
                                  validator: (v) => (v == null || v.trim().isEmpty)
                                      ? 'Please enter a medication name'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 5),
                              searchAnchor(),
                            ],
                          ),
                        ),
                        FormSection(
                          title: 'Dose Form',
                          child: OptionalFormField(
                            controller: _doseFormController,
                            hintText: 'Choose or enter a dose form',
                            options: const [
                              'Tablet', 'Capsule', 'Injection', 'Cream',
                              'Ointment', 'Gel', 'Patch', 'Solution',
                              'Suspension', 'Drops',
                            ],
                          ),
                        ),
                        FormSection(
                          title: 'Dose Strength',
                          child: TextFormField(
                            controller: _doseStrengthController,
                            decoration: formFieldDecoration(
                              context: context,
                              hintText: 'Enter the dose strength',
                            ),
                          ),
                        ),
                        FormSection(
                          title: 'Instructions',
                          child: TextFormField(
                            controller: _instructionsController,
                            maxLines: 4,
                            decoration: formFieldDecoration(
                              context: context,
                              hintText: 'Medication instructions',
                            ),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Please enter instructions'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: FormButton(
                            label: 'Confirm',
                            weight: FontWeight.w500,
                            radius: AppRadius.borderRadiusXl,
                            onPressed: () => _createMedication(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchAnchor() {
    return SearchAnchor(
      searchController: _rxNormController,
      builder: (BuildContext context, SearchController controller) {
        final cs = Theme.of(context).colorScheme;
        return SizedBox(
          width: 49,
          child: IconButton(
            onPressed: controller.openView,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minHeight: 49),
            icon: const Icon(Icons.search, size: 28),
            style: IconButton.styleFrom(
              backgroundColor: cs.outlineVariant,
              foregroundColor: cs.outline,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderRadiusXl,
              ),
            ),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        final List<Candidate>? results = await _debouncedSearch(controller.text);
        if (results == null) return _lastOptions;

        _lastOptions = results.map((candidate) {
          return ListTile(
            title: candidate.brandName.isNotEmpty
                ? Text(candidate.brandName)
                : Text(candidate.ingredientNames.first),
            onTap: () {
              setState(() {
                controller.closeView(candidate.brandName);
                _medicationController.text = candidate.brandName.isNotEmpty
                    ? candidate.brandName
                    : candidate.ingredientNames.first;
                _ingredientNames = candidate.ingredientNames;
                _rxcui = candidate.rxNorm;
              });
            },
          );
        }).toList();
        return _lastOptions;
      },
    );
  }
}