import 'package:background_processes/Domain/Repositories/postition_repository.dart';
import 'package:background_processes/data/Repositories/position_repository_impl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin GetCurrentUseCase{
  Future<LatLng> call();
}

class GetCurrent implements GetCurrentUseCase{
  @override
  Future<LatLng> call() async{
    final PositionRepository _positionRepository = PositionRepositoryImpl();
    return _positionRepository.getMyCurrentLocation();
  }
}