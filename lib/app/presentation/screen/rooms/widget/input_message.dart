import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trapper/generated/assets.dart';

import '../../../../../generated/l10n.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({super.key});

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  bool _showEmoji = false;
  Image? _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_image != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
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
            height: _showEmoji ? 200 : 0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Image.asset(Assets.assetsBanner);
                },
                itemCount: 32,
              ),
            )),
        const SizedBox(height: 8),
        TextField(
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
                    onPressed: () {},
                    icon: const Icon(Icons.send_sharp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _pickImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      if (value == null) return;
      var tmp = await value.readAsBytes();
      setState(() {
        _image = Image.memory(tmp);
      });
    });
  }
}
