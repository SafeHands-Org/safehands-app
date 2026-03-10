import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import 'package:frontend/features/auth/services/auth_service.dart';
import 'package:frontend/features/auth/pages/auth_page.dart';
import 'package:frontend/models/medications/medication_list.dart';
import 'package:frontend/features/medications/pages/member_medications_page.dart';
import 'package:frontend/models/medications/medication_provider.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await AuthService().getUserId();
    if (mounted) setState(() => _currentUserId = id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeHands',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.medication_outlined, color: Colors.white),
            tooltip: 'Medication Library',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MedicationListPage())),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await AuthService().clearToken();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AuthPage.routeName);
              }
            },
          ),
        ],
      ),
      drawer: _AppDrawer(currentUserId: _currentUserId),
      body: Consumer<MedicationProvider>(builder: (_, p, _) {
        if (p.loading) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
        }
        return _FamilyMemberList(
          currentUserId: _currentUserId,
          libraryMedCount: p.medications.length,
        );
      }),
    );
  }
}

//replace _placeholderMembers with real family members
class _FamilyMemberList extends StatelessWidget {
  final String? currentUserId;
  final int libraryMedCount;
  const _FamilyMemberList({this.currentUserId, required this.libraryMedCount});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: AppTheme.primary.withOpacity(0.06),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          const Icon(Icons.medication, color: AppTheme.primary, size: 20),
          const SizedBox(width: 8),
          Text('$libraryMedCount medication${libraryMedCount == 1 ? '' : 's'} in library',
              style: AppTheme.body.copyWith(color: AppTheme.primary, fontWeight: FontWeight.w600)),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MedicationListPage())),
            child: const Text('Manage'),
          ),
        ]),
      ),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _placeholderMembers.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final m = _placeholderMembers[i];
            return _FamilyMemberCard(
              memberId: m['id']!,
              memberName: m['name']!,
              currentUserId: currentUserId ?? '',
            );
          },
        ),
      ),
    ]);
  }
}

const _placeholderMembers = [
  {'id': 'replace-with-real-family-member-id-1', 'name': 'John D.'},
  {'id': 'replace-with-real-family-member-id-2', 'name': 'Maria S.'},
];

class _FamilyMemberCard extends StatefulWidget {
  final String memberId;
  final String memberName;
  final String currentUserId;
  const _FamilyMemberCard({
    required this.memberId, required this.memberName, required this.currentUserId,
  });

  @override
  State<_FamilyMemberCard> createState() => _FamilyMemberCardState();
}

class _FamilyMemberCardState extends State<_FamilyMemberCard> {
  @override
  void initState() {
    super.initState();
    if (!widget.memberId.startsWith('replace-with')) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<MedicationProvider>().loadMemberMeds(widget.memberId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final meds = p.forMember(widget.memberId);
      return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => MemberMedicationsPage(
            memberId: widget.memberId,
            memberName: widget.memberName,
            currentUserId: widget.currentUserId,
          ),
        )),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              Column(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.primary.withOpacity(0.15),
                  child: const Icon(Icons.person, color: AppTheme.primary),
                ),
                const SizedBox(height: 8),
                Text(widget.memberName,
                    style: AppTheme.body.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ]),
              const SizedBox(width: 16),
              Expanded(child: meds.isEmpty
                  ? Text('No medications assigned',
                      style: AppTheme.body.copyWith(color: Colors.grey))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: meds.take(4).map((m) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(children: [
                          const SizedBox(width: 6),
                          Expanded(child: Text(m.nameEntered ?? '', style: AppTheme.body)),
                          Container(
                            width: 8, height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: m.active ? Colors.green : Colors.grey,
                            ),
                          ),
                        ]),
                      )).toList(),
                    )),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ]),
          ),
        ),
      );
    });
  }
}

class _AppDrawer extends StatelessWidget {
  final String? currentUserId;
  const _AppDrawer({this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primary.withOpacity(0.7), AppTheme.primary],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SafeHands',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('Caregiver Dashboard',
                  style: TextStyle(color: Colors.white70, fontSize: 15)),
            ],
          ),
        ),
        _Tile(icon: Icons.dashboard, label: 'Dashboard',
            onTap: () => Navigator.pop(context)),
        _Tile(icon: Icons.medication, label: 'Medications',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MedicationListPage()));
            }),
        const Divider(),
        _Tile(icon: Icons.logout, label: 'Logout',
            onTap: () async {
              await AuthService().clearToken();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AuthPage.routeName);
              }
            }),
      ]),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: AppTheme.body),
      onTap: onTap,
    ),
  );
}