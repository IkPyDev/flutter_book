import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/play/play_bloc.dart';
import '../../domain/model/book_data.dart';
import '../home/pdf_screen.dart';

class Music extends StatelessWidget {
  const Music({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as BookData;
    final audioUrl = book.audio;
    final photoUrl = book.image;

    context.read<PlayBloc>().add(PlayFirstTimeEvent(url: audioUrl));

    return BlocConsumer<PlayBloc, PlayState>(
      listener: (context, state) {
        if (state.toPdfScreen) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => PDFScreen(
                url: book.pdf,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return Hero(
          tag: "HHHH",
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text(
                'Now Playing',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                  onPressed: () {
                    context.read<PlayBloc>().add(DisposeAudioEvent());
                    Navigator.pop(context);
                  },
                ),
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.26 + 30,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/img_top.png',
                          fit: BoxFit.cover,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PlayBloc>().add(OpenPdfEvent());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              height: height * 0.26,
                              width: width * 0.36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Chapter - 01',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        book.name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        book.author,
                        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        formatTime(state.position),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          min: 0.0,
                          max: state.duration.inSeconds.toDouble(),
                          value: state.position.inSeconds.toDouble(),
                          onChangeEnd: (double value) {
                            context.read<PlayBloc>().add(PlayAudioEvent(url: audioUrl));
                          },
                          onChanged: (double value) {
                            context.read<PlayBloc>().add(OnUserChangePositionEvent(position: Duration(seconds: value.toInt())));
                          },
                        ),
                      ),
                      Text(
                        formatTime(state.duration),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Image.asset(
                        'assets/ic_back.png',
                        height: 24,
                        width: 24,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.read<PlayBloc>().add(BackwardTenSecondsEvent());
                        },
                        child: Image.asset(
                          'assets/ic_double_back.png',
                          height: 32,
                          width: 32,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (state.isPlaying) {
                              context.read<PlayBloc>().add(PauseAudioEvent());
                            } else {
                              context.read<PlayBloc>().add(PlayAudioEvent(url: audioUrl));
                            }
                          },
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<PlayBloc>().add(ForwardTenSecondsEvent());
                        },
                        child: Image.asset(
                          'assets/ic_double_forward.png',
                          height: 32,
                          width: 32,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        'assets/ic_forward.png',
                        height: 24,
                        width: 24,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/ic_moon.png', height: 24, width: 24),
                      const SizedBox(width: 24),
                      Image.asset('assets/ic_cycle.png', height: 24, width: 24),
                      const SizedBox(width: 24),
                      Image.asset('assets/ic_bookmark.png', height: 24, width: 24),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_up_rounded,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        Text(
                          "CHAPTER",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;

    if (minutes == seconds && minutes == 0) {
      return '00:00';
    } else if (minutes < 9 && seconds < 9) {
      return '0$minutes:0$seconds';
    } else if (minutes < 9) {
      return '0$minutes:$seconds';
    } else if (seconds < 9) {
      return '$minutes:0$seconds';
    }

    return '${duration.inSeconds ~/ 60}:${duration.inSeconds % 60}';
  }
}
