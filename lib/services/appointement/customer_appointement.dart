import 'package:profinder/models/appointement/customer_appointment.dart';
import 'package:profinder/services/data.dart';

class CustomerAppointementService {
  final GenericDataService<CustomerAppointment> _genericService =
      GenericDataService<CustomerAppointment>('appointment', {
    'get': 'viewCustomer',
  });

  Future<List<CustomerAppointment>> fetch() async {
    return _genericService.fetch((json) => CustomerAppointment.fromJson(json));
  }
}
