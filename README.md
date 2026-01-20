# Remindly ⏰

Remindly is a simple, lightweight Flutter reminder library that allows you to  
schedule, edit, and cancel notifications at a specific **date and time**.

It is built on top of `awesome_notifications` and works smoothly on  
**Android 13+** and **iOS**.

---

## ✨ Features

- 🔔 Schedule reminders with date & time
- ✏️ Edit existing reminders
- ❌ Cancel a specific reminder
- 🧹 Cancel all reminders
- 🔁 Automatically replaces notification on edit (same ID)
- 📱 Android & iOS support
- 🧩 Clean and simple public API
- 🚀 Android 13+ notification permission handled

---

## Preview

https://github.com/user-attachments/assets/6ef59fef-cddf-4a40-9d9b-92993df0950b

## 📦 Installation

### Pub.dev

```
dependencies:
  flutter_remindly: ^1.0.0

https://github.com/user-attachments/assets/e5de9509-9f83-44b9-8f7d-907e6c3cf8bd


```
---
```
dependencies:
  flutter_remindly:
    git:
      url: https://github.com/your-username/flutter_remindly.git
```
## 🚀 Getting Started
```
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Remindly.initialize();
  runApp(const MyApp());
}
```
## ⏰ Create a Reminder
```
final reminder = Reminder(
  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  title: 'Drink Water',
  body: 'Stay hydrated',
  dateTime: DateTime(2025, 1, 1, 9, 0),
);
```


## ✏️ Edit a Reminder
```
final updatedReminder = Reminder(
  id: reminder.id, // same ID
  title: 'Drink More Water',
  body: 'Health reminder',
  dateTime: DateTime(2025, 1, 1, 10, 0),
);

await Remindly.setReminder(updatedReminder);
```

## ❌ Cancel a Reminder
```
await Remindly.cancelReminder(reminder.id);
```

## 🧹 Cancel All Reminders
```
await Remindly.cancelAll();
```

## 📁 Library Structure
```
flutter_remindly/
├── lib/
│   ├── home/
│   │   ├── add_reminder_dialog.dart   # Reminder dialog UI
│   │   ├── home.dart                  # Main screen
│   │   └── remindly.dart              # Public API
│   ├── model/
│   │   └── reminder.dart              # Reminder model
│   └── services/
│       ├── notification_service.dart  # Notification handling
│       └── permission_service.dart    # Permission handling
```
## 📄 License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
        

