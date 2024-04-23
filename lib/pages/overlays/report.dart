import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/report/report.dart';
import 'package:profinder/services/report/report.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ReportService reportService = ReportService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Envoyer un rapport',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                RoundedTextField(
                  controller: _titleController,
                  hintText: "Sujet",
                  icon: FluentIcons.text_header_1_lines_16_filled,
                ),
                RoundedTextArea(
                  controller: _contentController,
                  hintText: "Message",
                  icon: FluentIcons.text_paragraph_16_filled,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FilledAppButton(
              icon: FluentIcons.send_16_filled,
              text: "Envoyer",
              onPressed: () async {
                final String reportContent =
                    'Sujet: ${_titleController.text}, Contenu: ${_contentController.text}';
                ReportEntity report =
                    new ReportEntity(description: reportContent);

                try {
                  await reportService.post(report);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Rapport envoyé'), // Confirmation message
                      duration:
                          Duration(seconds: 2), // Adjust the duration as needed
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erreur $e'), // Confirmation message
                      duration:
                          Duration(seconds: 2), // Adjust the duration as needed
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
