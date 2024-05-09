import 'package:equatable/equatable.dart';

abstract class EarthQuakeEvent extends Equatable {
  const EarthQuakeEvent();
}

class EarthQuakePageReadyEvent extends EarthQuakeEvent {
  @override
  List<Object> get props => [];
}

class SubmitDataRequestEvent extends EarthQuakeEvent {
  final String date;
  final String magnitude;

  SubmitDataRequestEvent({
    required this.date,
    required this.magnitude,
  });

  @override
  List<Object> get props => [
        date,
        date,
      ];
}
