import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/features/utils/year_util.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';
import 'package:eurovision_app/core/providers/base_list_provider.dart';
import 'package:eurovision_app/core/result/result.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoProvider extends BaseListProvider<ContestantDetailModel> {
  final ContestantDetailRemoteDatasourceImpl _detailDatasource = ContestantDetailRemoteDatasourceImpl();
  final DioApiManager _dio = DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  final Map<int, YoutubePlayerController> _controllers = {};
  Map<int, YoutubePlayerController> get controllers => _controllers;

  int _selectedYear = YearUtil.getLatestAvailableYear();
  int get selectedYear => _selectedYear;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  Future<void> updateYear(int year) async {
    if (isDisposed) return;
    _selectedYear = year;
    notifyListeners();

    final result = await _dio.get<Map<String, dynamic>>(
      '/contests/$year',
      converter: (data) => data,
    );

    final contestants = result.data?['contestants'] as List? ?? [];
    final ids = contestants.map((e) => (e as Map<String, dynamic>)['id'] as int).toList();

    await fetchAllWithVideos(ids, year);
  }

  Future<void> fetchAllWithVideos(List<int> contestantIds, int year) async {
    if (isDisposed) return;
    setLoading();

    _disposeControllers();

    final List<ContestantDetailModel> list = [];

    for (int id in contestantIds) {
      if (isDisposed) return;

      final result = await _detailDatasource.fetchContestantDetail(year: year, id: id);
      if (result is SuccessDataResult<ContestantDetailModel>) {
        final data = result.data!;
        if (data.videoUrls.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(data.videoUrls.first);
          if (videoId != null && videoId.isNotEmpty) {
            if (isDisposed) return;
            _controllers[id] = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
                enableCaption: true,
              ),
            );
            list.add(data);
          }
        }
      }
    }

    if (isDisposed) return;
    setLoaded(list);
  }

  void _disposeControllers() {
    for (final controller in _controllers.values) {
      if (!controller.value.isFullScreen) {
        controller.dispose();
      }
    }
    _controllers.clear();
  }

  @override
  void dispose() {
    _disposeControllers();
    _isDisposed = true;
    super.dispose();
  }
}