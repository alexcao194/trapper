import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/message_detail.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import '../../../bloc/sticker/sticker_bloc.dart';
import 'sticker.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({super.key});

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  bool _showEmoji = false;
  Image? _image;
  Uint8List? _imageBytes;
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.5,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(image: _image!.image),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: const Icon(Icons.close_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showEmoji ? 400 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.current.search, style: Theme.of(context).textTheme.titleMedium),
                      SearchBar(
                        onChanged: (value) {
                          context.read<StickerBloc>().add(StickerFilter(query: value));
                        },
                        hintText: S.current.search_hint,
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.background),
                        leading: const Icon(Icons.search),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(color: Theme.of(context).colorScheme.primary))),
                      ),
                      const SizedBox(height: 16),
                      Text(S.current.emoji, style: Theme.of(context).textTheme.titleMedium),
                      Expanded(
                        child: BlocBuilder<StickerBloc, StickerState>(
                          builder: (context, stickerState) {
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: size.width ~/ 100,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Sticker(
                                    src: stickerState.stickers[index].url,
                                  ),
                                );
                              },
                              itemCount: stickerState.stickers.length,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: S.current.text_message_hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.background,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      _pickImage();
                    },
                    icon: const Icon(Icons.image_outlined),
                  ),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          var roomID = state.roomsInfo.firstWhere((element) => element.id == state.currentID).id!;
                          _sendMessage(roomID);
                        },
                        icon: const Icon(Icons.send_sharp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pickImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      if (value == null) return;
      _imageBytes = await value.readAsBytes();
      setState(() {
        _image = Image.memory(_imageBytes!);
      });
    });
  }

  void _sendMessage(String roomID) {
    if (_controller.text.isNotEmpty) {
      var message = MessageDetail(
        message: _controller.text,
        type: MessageType.text,
      );
      _controller.clear();
      context.read<RoomsBloc>().add(RoomsSendMessage(roomID: roomID, message: message));
    }

    if (_imageBytes != null) {
      var message = MessageDetail(
        type: MessageType.image,
        image: _imageBytes,
      );
      _imageBytes = null;
      setState(() {
        _image = null;
      });
      context.read<RoomsBloc>().add(RoomsSendMessage(roomID: roomID, message: message));
    }
  }
}
