import 'package:flutter/material.dart';
import 'package:profinder/models/appointement/appointment_creation_request.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

class CreateAppointmentPage extends StatefulWidget {
  final int serviceId;
  final String professionalId;

  const CreateAppointmentPage({
    Key? key,
    required this.professionalId,
    required this.serviceId,
  }) : super(key: key);

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  late String description;
  final AppointementService appointment = AppointementService();
  final TextEditingController _descriptionController = TextEditingController();

  AppointementCreationRequest buildRequest() {
    return AppointementCreationRequest(
      description: _descriptionController.text,
      serviceId: widget.serviceId,
      professionalId: widget.professionalId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un rendez-vous'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedTextArea(
              controller: _descriptionController,
              hintText: "Description",
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FilledAppButton(
                onPressed: () async {
                  try {
                    await appointment.post(buildRequest());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Rendez-vous créé'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Veuillez vérifier vos coordonnées'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                text: 'Confirmer',
                icon: Icons.check,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
