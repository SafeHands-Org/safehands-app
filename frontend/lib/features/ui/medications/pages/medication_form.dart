
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/medications/widgets/medication_form_helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class MedicationFormView extends StatefulWidget {
  const MedicationFormView({super.key});

  @override
  State<MedicationFormView> createState() => _MedicationFormViewState();
}

class _MedicationFormViewState extends State<MedicationFormView> {
  final SearchController _rxNormController = SearchController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _doseFormController = TextEditingController();
  final TextEditingController _doseStrengthController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _rxcui;

  String? _currentQuery;
  late Iterable<Widget> _lastOptions = const <Widget>[];
  late final Debounceable<List<Candidate>?, String> _debouncedSearch;

  Future<List<Candidate>?> _search(String query) async {
    _currentQuery = query;

    if (query.isEmpty) {
      return const [];
    }

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
      if (c['rank'] == '1' && c['name'] != null && c['source'] == 'RXNORM') {
        seen.add( Candidate(name: c['name'] as String, rxNorm: c['rxNorm'] as String));
      }
    }

    return seen.toList();
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = debounce<List<Candidate>?, String>(_search);
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

    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/medications')
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Container(
            width: double.infinity,
            height: 500,
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
            child: ListView(
              children: [
                SectionHeader(title: 'Create a new medication'),
                FormSection(
                  title: 'Medication Name',
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _medicationController,
                          decoration: formFieldDecoration(context: context),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a medication name' : null,
                        ),
                      ),
                      SizedBox(width: 5),
                      searchAnchor()
                    ]
                  ),
                ),
                FormSection(
                  title: 'Dose Form',
                  child: OptionalFormField(
                    controller: _doseFormController,
                    hintText: 'Choose or enter a dose form',
                    options: const [
                      'Tablet',
                      'Capsule',
                      'Injection',
                      'Cream',
                      'Ointment',
                      'Gel',
                      'Patch',
                      'Solution',
                      'Suspension',
                      'Drops',
                    ],
                  ),
                ),
                FormSection(
                  title: 'Dose Strength',
                  child: TextFormField(
                    controller: _doseStrengthController,
                    decoration: formFieldDecoration(context: context, hintText: 'Enter a dose strength'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a dose strength' : null,
                  )
                ),
                FormSection(
                  title: 'Dose Strength',
                  child: TextFormField(
                    controller: _doseStrengthController,
                    decoration: formFieldDecoration(context: context, hintText: "Enter the medication instructions")
                  )
                ),
                FormButton(
                  label: 'Create Family',
                  onPressed: () => _createMedication(),
                  weight: FontWeight.w400,
                  radius: AppRadius.borderRadiusXl,
                  buttonColor: cs.errorContainer,
                  borderColor: cs.error,
                  textColor: cs.error,
                ),
              ],
            )
          )
        )
      )
    );
  }
  Widget searchAnchor(){
    return SearchAnchor(
      searchController: _rxNormController,
      builder: (BuildContext context, SearchController controller) {
        final cs = Theme.of(context).colorScheme;
        return SizedBox(
          width: 49,
          child: IconButton(
            onPressed: controller.openView,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minHeight: 49),
            icon: Icon(Icons.search, size: 28),
            style: IconButton.styleFrom(
              backgroundColor: cs.outlineVariant,
              foregroundColor: cs.outline,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusXl)
            )
          )
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        final List<Candidate>? results = await _debouncedSearch(
          controller.text,
        );

        if (results == null) return _lastOptions;

        _lastOptions = results.map((candidate) {
          return ListTile(
            title: Text(candidate.name),
            onTap: () {
              final String selectedName = candidate.name;
              final String selectedRxcui = candidate.rxNorm;
              print('Name: $selectedName');
              print('RXCUI: $selectedRxcui');
              setState(() {
                controller.closeView(selectedName);
                _medicationController.value = TextEditingValue(text: controller.text);
                _rxcui = selectedRxcui;
              });
            },
          );
        }).toList();
        return _lastOptions;
      },
    );
  }
}
