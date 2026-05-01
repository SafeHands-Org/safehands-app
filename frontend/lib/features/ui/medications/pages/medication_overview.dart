import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/medications/widgets/medication_card.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class MedicationsView extends ConsumerWidget {
  const MedicationsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final medicationsAsync = ref.watch(medicationsProvider);

    switch (medicationsAsync) {
      case AsyncLoading(): return MedicationScaffold(child: LoadingBody());
      case AsyncError(): return MedicationScaffold(child: ErrorBody(callback: () async => ref.refresh(medicationsProvider)));
      case AsyncData(:final value):
        if (value.isEmpty){
          return MedicationScaffold(
            child: EmptyBody(
              type: 'medications',
              role: UserRole.caregiver,
              refresh: () => ref.refresh(medicationsProvider),
              redirect: () => context.push('/medications/create')
            )
          );
        }
        return Scaffold (
          appBar: AppBar(
            leading: BackButton(
              color: cs.onInverseSurface,
              onPressed: () => context.canPop() ? context.pop() : context.go('/')
            ),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
            title: Text(
              'My Medications',
              style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
              textAlign: TextAlign.center
            )
          ),
          body: RefreshIndicator(
            onRefresh: () => ref.refresh(medicationsProvider.future),
            child: Container(
              decoration: BoxDecoration(gradient: context.palette.page),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeader(title: 'All Medications (${value.length})'),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 16),
                                  child: MedicationList(medications: value)
                                )

                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  )
                ]
              )
            )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/medications/create'),
            foregroundColor: cs.onTertiaryContainer,
            backgroundColor: cs.tertiaryContainer,
            child: const Icon(Icons.add)
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }
}

class MedicationScaffold extends StatelessWidget{
  const MedicationScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/')
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'My Medications',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center
        )
      ),
      body: child
    );
  }
}