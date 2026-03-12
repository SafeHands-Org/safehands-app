import 'package:flutter/material.dart';
import 'package:frontend/controllers/medication_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/medications/widgets/adherence_section.dart';
import 'package:frontend/features/medications/widgets/medication_tab.dart';
import 'package:frontend/features/medications/widgets/schedule_section.dart';
import 'package:provider/provider.dart';

class MemberMedicationsPage extends StatefulWidget {
  final String memberId;
  final String memberName;
  final String currentUserId;

  const MemberMedicationsPage({
    super.key,
    required this.memberId,
    required this.memberName,
    required this.currentUserId,
  });

  @override
  State<MemberMedicationsPage> createState() => MemberMedicationsPageState();
}

class MemberMedicationsPageState extends State<MemberMedicationsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MedicationController>().loadMemberMeds(widget.memberId);
    });
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.memberName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Medications'),
            Tab(text: 'Schedules'),
            Tab(text: 'Adherence'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          MedicationsTab(
            memberId: widget.memberId,
            memberName: widget.memberName,
            currentUserId: widget.currentUserId,
          ),
          SchedulesTab(memberId: widget.memberId),
          AdherenceTab(
            memberId: widget.memberId,
            currentUserId: widget.currentUserId,
          ),
        ],
      ),
    );
  }
}