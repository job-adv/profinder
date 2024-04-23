class ProfessionalAppointment {
  final int? appointmentId;
  final String? description;
  final String? date;
  final String? time;
  final String? status;
  final Service service;
  final Customer customer;

  ProfessionalAppointment({
    required this.appointmentId,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
    required this.service,
    required this.customer,
  });

  factory ProfessionalAppointment.fromJson(Map<String, dynamic> json) {
    return ProfessionalAppointment(
      appointmentId: json['appointment_id'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      service: Service.fromJson(json['service']),
      customer: Customer.fromJson(json['customer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'description': description,
      'date': date,
      'time': time,
      'service': service.toJson(),
      'customer': customer.toJson(),
    };
  }
}

class Service {
  final int serviceId;
  final String title;
  final String description;
  final String status;

  Service({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}

class Customer {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String role;
  final String? phoneNumber;

  Customer({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    this.phoneNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'role': role,
    };
  }
}
