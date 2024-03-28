import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/custom_chip.dart';

List<String> hobbiesList = <String>[
  'Du lịch',
  'Đọc sách',
  'Nghe nhạc',
  'Xem phim',
  'Chơi game',
  'Code',
  'Thể thao',
  'Nấu ăn',
  'Học hỏi',
  'Thiền',
  'Yoga',
  'Chăm sóc thú cưng',
  'Chơi nhạc',
  'Vẽ tranh',
  'Ẩm thực',
  'Pha chế',
  'Thủy cung',
  'Cà phê',
  'Trà sữa',
  'Rượu',
  'Cắm hoa',
  'Tarots',
  'Thiên văn học',
  'Chụp ảnh'
];

List<String> genders = <String>['Nam', 'Nữ', 'Tất cả'];

class ConnectTab extends StatelessWidget {
  const ConnectTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Bạn muốn tìm người như thế nào?',
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Text('Tuổi: '),
                Spacer(),
                Text('21 - 23'),
              ],
            ),
            RangeSlider(
              min: 18,
              max: 50,
              values: const RangeValues(21, 23),
              onChanged: (values) {},
            ),
            const SizedBox(height: 20),
            const Text('Giới tính: '),
            Wrap(
              children: genders
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomChip(
                          label: e,
                          isSelected: true,
                          onSelected: (bool selected) {},
                        ),
                      ))
                  .toList(),
            ),
            const Text('Sở thatch: '),
            Wrap(
              children: hobbiesList.map((hobby) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomChip(
                    label: hobby,
                    isSelected: false,
                    onSelected: (bool selected) {},
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        Text('Tìm kiếm'),

                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
