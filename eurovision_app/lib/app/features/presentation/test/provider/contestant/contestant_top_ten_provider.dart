import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/core/providers/base_list_manager.dart';


class MyTop10Provider extends BaseListManager<ContestantModel> {
  List<ContestantModel> get top10 => getTop(10);
}
