import 'package:flutter/material.dart';
import 'package:flutter_remindly/model/reminder.dart';
import 'package:intl/intl.dart';

class AddReminderDialog extends StatefulWidget {
  final Reminder? reminder; // ✅ for edit mode

  const AddReminderDialog({super.key, this.reminder});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();

    if (widget.reminder != null) {
      // EDIT MODE
      _titleController =
          TextEditingController(text: widget.reminder!.title);
      _noteController =
          TextEditingController(text: widget.reminder!.body);

      _selectedDate = widget.reminder!.dateTime;
      _selectedTime =
          TimeOfDay.fromDateTime(widget.reminder!.dateTime);
    } else {
      // ADD MODE
      _titleController = TextEditingController();
      _noteController = TextEditingController();
    }
  }

  String get formattedDate =>
      _selectedDate == null
          ? 'Choose Date'
          : DateFormat.yMMMd().format(_selectedDate!);

  String get formattedTime =>
      _selectedTime == null
          ? 'Choose Time'
          : _selectedTime!.format(context);

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _saveReminder() {
    if (_titleController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final reminder = Reminder(
      // ✅ keep same ID when editing
      id: widget.reminder?.id ??
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: _titleController.text,
      body: _noteController.text,
      dateTime: dateTime,
    );

    Navigator.pop(context, reminder);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.reminder == null
                    ? 'Add Reminder'
                    : 'Edit Reminder',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Reminder Title',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),

              const SizedBox(height: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(formattedDate),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time),
                    label: Text(formattedTime),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveReminder,
                  child: const Text('Save Reminder'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
