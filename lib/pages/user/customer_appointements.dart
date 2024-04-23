import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/models/appointement/customer_appointment.dart';
import 'package:profinder/models/review/review_creation_request.dart';
import 'package:profinder/services/appointement/appointement.dart';
import 'package:profinder/services/appointement/customer_appointement.dart';
import 'package:profinder/services/review/review.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class CustomerAppointments extends StatefulWidget {
  const CustomerAppointments({Key? key}) : super(key: key);

  @override
  State<CustomerAppointments> createState() => _CustomerAppointmentsState();
}

class _CustomerAppointmentsState extends State<CustomerAppointments> {
  late Future<List<CustomerAppointment>> _appointments;

  final CustomerAppointementService _appointmentService =
      CustomerAppointementService();

  final AppointementService appointementService = AppointementService();
  final ReviewService reviewService = ReviewService();

  Future<void> _loadAppointments() async {
    _appointments = _appointmentService.fetch();
  }

  void _updateAppointments() {
    setState(() {
      _loadAppointments();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: VerticalList(
              future: _appointments,
              itemBuilder: (appointment) {
                return Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  elevation: 0.8,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      appointment.description!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Professionel: ${appointment.professional.firstname} ${appointment.professional.lastname}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Date: ${appointment.date ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text('Temps: ${appointment.time ?? 'N/D'}'),
                        SizedBox(height: 4),
                        Text(
                            'Status: ${Helpers.getAppointementStatus(appointment.status)}'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (appointment.status == 'pending')
                              FilledAppButton(
                                icon: Icons.cancel,
                                text: "Annuler",
                                onPressed: () async {
                                  AppointementUpdateRequest req =
                                      AppointementUpdateRequest(
                                    state: 'cancelled',
                                  );
                                  await appointementService.update(
                                      req, appointment.appointmentId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Rendez-vous annulé'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  _updateAppointments();
                                },
                              ),
                            if (appointment.status == 'confirmed')
                              Expanded(
                                child: FilledAppButton(
                                  icon: Icons.star,
                                  text: "Évaluer",
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        int rating = 0;
                                        TextEditingController
                                            _commentController =
                                            TextEditingController();

                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          title: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Évaluer le service',
                                              style: AppTheme.headingTextStyle,
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Star rating widget
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 1,
                                                ),
                                                onRatingUpdate: (value) {
                                                  rating = value
                                                      .toInt(); // Update rating when user selects stars
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              // Text field for comment
                                              RoundedTextArea(
                                                  controller:
                                                      _commentController,
                                                  hintText:
                                                      "Entrez votre commentaire..."),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FilledAppButton(
                                                      icon: Icons.check,
                                                      text: "Envoyer",
                                                      onPressed: () async {
                                                        ReviewCreationRequest
                                                            req =
                                                            ReviewCreationRequest(
                                                          comment:
                                                              _commentController
                                                                  .text,
                                                          rating: rating,
                                                          serviceId: appointment
                                                              .service
                                                              .serviceId,
                                                        );

                                                        await reviewService
                                                            .post(req);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Évaluation soumise',
                                                            ),
                                                            duration: Duration(
                                                              seconds: 3,
                                                            ),
                                                          ),
                                                        );
                                                        _updateAppointments();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              errorMessage: "Aucun rendez-vous",
              emptyText: "Aucun rendez-vous",
            ),
          ),
        ],
      ),
    );
  }
}
