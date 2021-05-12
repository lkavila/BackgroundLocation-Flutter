import 'package:background_processes/Domain/Repositories/postition_repository.dart';
import 'package:background_processes/data/Repositories/position_repository_impl.dart';

mixin StartUseCase{
  void call();
}

class StartUpdates implements StartUseCase{
  @override
  void call() async{
    final PositionRepository _positionRepository = PositionRepositoryImpl();
    _positionRepository.startUpdates();
  }
}