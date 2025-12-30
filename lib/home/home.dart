import 'package:flutter/material.dart';
import 'package:flutter_remindly/model/reminder.dart';
import 'package:flutter_remindly/home/remindly.dart';
import 'package:intl/intl.dart';
import 'add_reminder_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    Remindly.initialize();
  }

  /// ADD reminder
  void _openAddReminderDialog() async {
    final reminder = await showDialog<Reminder>(
      context: context,
      builder: (_) => const AddReminderDialog(),
    );

    if (reminder != null) {
      setState(() {
        _reminders.add(reminder);
        _reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });

      // Schedule notification
      Remindly.setReminder(reminder);
    }
  }

  /// EDIT reminder
  void _openEditReminderDialog(Reminder reminder, int index) async {
    final updatedReminder = await showDialog<Reminder>(
      context: context,
      builder: (_) => AddReminderDialog(reminder: reminder),
    );

    if (updatedReminder != null) {
      setState(() {
        _reminders[index] = updatedReminder;
        _reminders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });

      // Cancel old & reschedule
      Remindly.cancelReminder(reminder.id);
      Remindly.setReminder(updatedReminder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remindly'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddReminderDialog,
        child: const Icon(Icons.add),
      ),
      body: _reminders.isEmpty
          ? const Center(
        child: Text(
          'Tap + to add reminder',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(reminder.title),
              subtitle: Text(
                reminder.body.isEmpty
                    ? DateFormat.yMMMd()
                    .add_jm()
                    .format(reminder.dateTime)
                    : '${reminder.body}\n${DateFormat.yMMMd().add_jm().format(reminder.dateTime)}',
              ),
              isThreeLine: reminder.body.isNotEmpty,

              /// 🔹 TAP TO EDIT
              onTap: () =>
                  _openEditReminderDialog(reminder, index),

              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _reminders.removeAt(index);
                  });
                  Remindly.cancelReminder(reminder.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
