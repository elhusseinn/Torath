// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torath/core/commonWidgets/Loader.dart';
import 'package:torath/core/commonWidgets/pageTemplate/page_template.dart';
import 'package:torath/cubits/filterCubits/getAllPlacesTimesCubit/get_all_places_times_cubit.dart';
import 'package:torath/cubits/filterCubits/getAllPlacesTimesCubit/get_all_places_times_state.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_cubit.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_state.dart';
import 'package:torath/screens/mahfalItemScreen/widgets/mahfal_screen.dart';

class MahfalItemScreen extends StatefulWidget {
  String surahName;

  MahfalItemScreen({super.key, required this.surahName});

  @override
  State<MahfalItemScreen> createState() => _MahfalItemScreenState();
}

class _MahfalItemScreenState extends State<MahfalItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMahfalCubit>().getMahfal(surah: widget.surahName);
  }

  void applyFilter(List<String>? places, List<String>? times) {
    context
        .read<GetMahfalCubit>()
        .getMahfal(surah: widget.surahName, places: places, times: times);
  }

  List<String> places = [];
  List<String> times = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllPlacesCubit, GetAllPlacesState>(
      builder: (filterContext, filterState) {
        if (filterState is GetAllPlacesLoadingState) {
          return Loader();
        }
        return BlocBuilder<GetMahfalCubit, GetMahfalState>(
          builder: (context, state) {
            if (state is GetMahfalSuccessState) {
              return PageTemplate(
                page: MahfalScreen(
                  data: state.response.data!,
                  filterPlaces: places,
                  filterTimes: times,
                  filter: applyFilter,
                ),
              );
            } else if (state is GetMahfalLoadingState) {
              return Loader();
            } else if (state is GetMahfalErrorState) {
              return Container(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
      listener: (filterContext, filterState) {
        if (filterState is GetAllPlacesSuccessState) {
          places = filterState.response.places.toList();
          times = filterState.response.times.toList();
        }
      },
    );
  }
}
