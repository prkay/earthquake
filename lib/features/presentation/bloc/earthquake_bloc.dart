import 'package:earthquake/features/model/earthquake_data_model.dart';
import 'package:earthquake/features/presentation/repository/getearthquakedata_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class EarthQuakeBloc
    extends Bloc<EarthQuakeEvent, EarthQuakeState> {
  @override
  EarthQuakeState get initialState => EmptyState(false);

  @override
  Stream<EarthQuakeState> mapEventToState(
      EarthQuakeEvent event) async* {
    if (event is EarthQuakePageReadyEvent) {
      yield EarthQuakeLoadingState(false);
    }else if(event is SubmitDataRequestEvent){
      yield* submitGetDataRequest(event.date,event.magnitude);
    }
  }
  Stream<EarthQuakeState> submitGetDataRequest(String date,String magnitude) async* {
    yield EarthQuakeLoadingState(true);
      final result = await GetEarthQuakDataRepostiory.getEarthQuakeData(date, magnitude);
      if(result == false){
        print(false);
        yield EarthQuakeDataLoadingFailedState(false);
      }else{
        List<Features> features = result.features;
        yield EarthQuakeDataLoadingSuccessState(false,features);
      }
  }
}