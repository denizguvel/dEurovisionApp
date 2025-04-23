import 'dart:async';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/utils/year_util.dart';
import 'package:eurovision_app/core/config/env_config.dart';
import 'package:eurovision_app/core/dio_manager/dio_manager.dart';
import 'package:eurovision_app/core/providers/base_list_provider.dart';
import 'package:eurovision_app/core/result/result.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoProvider extends BaseListProvider<ContestantDetailModel> {
  final ContestantDetailRemoteDatasourceImpl _detailDatasource = ContestantDetailRemoteDatasourceImpl();
  final DioApiManager _dio = DioApiManager(baseUrl: EnvConfig.eurovisionBaseUrl);

  final Map<int, YoutubePlayerController> _controllers = {};
  Map<int, YoutubePlayerController> get controllers => _controllers;

  int _selectedYear = YearUtil.getLatestAvailableYear();
  int get selectedYear => _selectedYear;

  List<int> _availableYears = [];
  List<int> get availableYears => _availableYears;

  List<int> _allContestantIds = [];
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  String _artistFilter = '';
  final List<ContestantModel> _allContestantsGlobal = [];

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? debounce;

  Future<void> init() async {
    scrollController.addListener(_scrollListener);
    await loadAvailableYears();
    await loadAllContestantsGlobal(); 
    await updateYear(_availableYears.first);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 && hasMore && !isLoading) {
      fetchNextPage();
    }
  }

  void onSearchChanged(String value) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        updateYear(selectedYear);
      } else {
        setArtistFilterGlobal(value);
      }
    });
  }

  void clearSearch() {
    searchController.clear();
    _artistFilter = ''; 
    updateYear(selectedYear);
  }

  Future<void> loadAvailableYears() async {
    final result = await _detailDatasource.fetchAvailableYears();
    if (result is SuccessDataResult<List<int>>) {
      _availableYears = result.data!..sort((a, b) => b.compareTo(a));
      notifyListeners();
    }
  }

  Future<void> loadAllContestantsGlobal() async {
    _allContestantsGlobal.clear();
    for (int year in _availableYears) {
      final response = await _dio.get<Map<String, dynamic>>(
        '/contests/$year',
        converter: (data) => data,
      );
      final contestants = response.data?['contestants'] as List? ?? [];
      _allContestantsGlobal.addAll(
        contestants.map((json) => ContestantModel.fromJson(json, year)),
      );
    }
  }

  void setArtistFilter(String artist) {
    _artistFilter = artist.toLowerCase();
    updateYear(_selectedYear);
  }

  void setArtistFilterGlobal(String artist) {
    _artistFilter = artist.toLowerCase();
    searchByArtistGlobal();
  }

  Future<void> updateYear(int year) async {
    if (isDisposed) return;
    _selectedYear = year;
    _currentPage = 0;
    _hasMore = true;
    _disposeControllers();
    notifyListeners();

    final result = await _dio.get<Map<String, dynamic>>(
      '/contests/$year',
      converter: (data) => data,
    );

    final contestants = result.data?['contestants'] as List? ?? [];
    _allContestantIds = contestants
        .where((e) =>
            _artistFilter.isEmpty ||
            (e['artist'] as String).toLowerCase().contains(_artistFilter))
        .map((e) => (e as Map<String, dynamic>)['id'] as int)
        .toList();

    setLoaded([]); 
    await fetchNextPage();
  }

  Future<void> searchByArtistGlobal() async {
    _currentPage = 0;
    _hasMore = true;
    _disposeControllers();

    final filtered = _allContestantsGlobal
        .where((contestant) => contestant.artist.toLowerCase().contains(_artistFilter))
        .toList();

    _allContestantIds = filtered.map((e) => e.id).toList();
    setLoaded([]);
    await fetchNextPageGlobal(filtered);
  }

  Future<void> fetchNextPage() async {
    if (!_hasMore || isDisposed || isLoading) return;
    setLoading();

    final start = _currentPage * _pageSize;
    final end = (_currentPage + 1) * _pageSize;
    final ids = _allContestantIds.sublist(
      start,
      end > _allContestantIds.length ? _allContestantIds.length : end,
    );

    final List<ContestantDetailModel> list = [];

    for (int id in ids) {
      if (isDisposed) return;

      final result = await _detailDatasource.fetchContestantDetail(
          year: _selectedYear, id: id);
      if (result is SuccessDataResult<ContestantDetailModel>) {
        final data = result.data!;
        if (data.videoUrls.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(data.videoUrls.first);
          if (videoId != null && videoId.isNotEmpty) {
            if (isDisposed) return;
            _controllers[id] = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                  autoPlay: false, mute: false, enableCaption: true),
            );
            list.add(data);
          }
        }
      }
    }

    final updatedList = [...items, ...list];
    setLoaded(updatedList);
    _currentPage++;
    _hasMore = end < _allContestantIds.length;
  }

  Future<void> fetchNextPageGlobal(List<ContestantModel> filteredContestants) async {
    if (!_hasMore || isDisposed || isLoading) return;
    setLoading();

    final start = _currentPage * _pageSize;
    final end = (_currentPage + 1) * _pageSize;
    final pagedContestants = filteredContestants.sublist(
      start,
      end > filteredContestants.length ? filteredContestants.length : end,
    );

    final List<ContestantDetailModel> list = [];

    for (var contestant in pagedContestants) {
      if (isDisposed) return;

      final result = await _detailDatasource.fetchContestantDetail(
        year: contestant.year,
        id: contestant.id,
      );

      if (result is SuccessDataResult<ContestantDetailModel>) {
        final data = result.data!;
        if (data.videoUrls.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(data.videoUrls.first);
          if (videoId != null && videoId.isNotEmpty) {
            if (isDisposed) return;
            _controllers[contestant.id] = YoutubePlayerController(
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

    final updatedList = [...items, ...list];
    setLoaded(updatedList);
    _currentPage++;
    _hasMore = end < filteredContestants.length;
  }

  void _disposeControllers() {
    for (final controller in _controllers.values) {
      if (!controller.value.isFullScreen) controller.dispose();
    }
    _controllers.clear();
  }

  @override
  void dispose() {
    _disposeControllers();
    scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    _isDisposed = true;
    super.dispose();
  }
}