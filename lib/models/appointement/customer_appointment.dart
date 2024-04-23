class CustomerAppointment {
  final int? appointmentId;
  final String? description;
  final String? date;
  final String? time;
  final Service service;
  final Professional professional;
  final String? status;

  CustomerAppointment({
    this.appointmentId,
    this.description,
    this.date,
    this.time,
    required this.status,
    required this.service,
    required this.professional,
  });

  factory CustomerAppointment.fromJson(Map<String, dynamic> json) {
    return CustomerAppointment(
      appointmentId: json['appointment_id'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      service: Service.fromJson(json['service']),
      professional: Professional.fromJson(json['professional']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'description': description,
      'date': date,
      'time': time,
      'service': service.toJson(),
      'professional': professional.toJson(),
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

class Professional {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String role;

  Professional({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      role: json['role'],
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
