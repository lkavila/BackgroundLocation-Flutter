import 'package:background_processes/Domain/Repositories/postition_repository.dart';
import 'package:background_processes/data/Repositories/position_repository_impl.dart';

mixin StopUseCase{
  void call();
}

class StopUpdates implements StopUseCase{
  @override
  void call() async{
    final PositionRepository _positionRepository = PositionRepositoryImpl();
    _positionRepository.stopUpdates();
  }
}