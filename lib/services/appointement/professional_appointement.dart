import 'package:profinder/models/appointement/professional_appointment.dart';
import 'package:profinder/services/data.dart';

class ProfessionalAppointementService {
  final GenericDataService<ProfessionalAppointment> _genericService =
      GenericDataService<ProfessionalAppointment>('appointment', {
    'get': 'viewProfessional',
  });

  Future<List<ProfessionalAppointment>> fetch() async {
    return _genericService
        .fetch((json) => ProfessionalAppointment.fromJson(json));
  }
}
