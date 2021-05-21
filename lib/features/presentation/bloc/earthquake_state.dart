import 'package:earthquake/features/model/earthquake_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class EarthQuakeState extends Equatable {
  const EarthQuakeState();
}

class EmptyState extends EarthQuakeState {
  final bool isLoading;
  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class EarthQuakeLoadingState extends EarthQuakeState {
  final bool isLoading;

  EarthQuakeLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class EarthQuakeDataLoadingSuccessState extends EarthQuakeState {
  final bool isLoading;
  final List<Features> features;

  EarthQuakeDataLoadingSuccessState(this.isLoading,this.features);

  @override
  List<Object> get props => [isLoading,features];
}
class EarthQuakeDataLoadingFailedState extends EarthQuakeState {
  final bool isLoading;

  EarthQuakeDataLoadingFailedState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}