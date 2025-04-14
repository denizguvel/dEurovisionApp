import 'package:eurovision_app/core/providers/base_selectable_list_provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

class SelectedTop10Provider extends BaseSelectableListProvider<ContestantModel> {
  SelectedTop10Provider() : super(maxItems: 10);
}
