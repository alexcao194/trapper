import 'package:flutter/material.dart';

List<String> hobbiesList = <String>[
  'Du lịch', 'Đọc sách', 'Nghe nhạc', 'Xem phim', 'Chơi game', 'Code', 'Thể thao', 'Nấu ăn',
  'Học hỏi', 'Thiền', 'Yoga', 'Chăm sóc thú cưng', 'Chơi nhạc', 'Vẽ tranh', 'Ẩm thực',
  'Pha chế', 'Thủy cung', 'Cà phê', 'Trà sữa', 'Rượu', 'Cắm hoa', 'Tarots', 'Thiên văn học',
  'Chụp ảnh', 'Thời trang', 'Mua sắm', 'Đi chợ', 'Chăm sóc cây cảnh', 'Chơi bài',
  'Cờ vua', 'Bóng đá', 'Bóng rổ', 'Bóng chuyền', 'Bơi lội', 'Đi bộ', 'Đạp xe',
  'Chạy bộ', 'Thể hình', 'Gym', 'Thể dục dụng cụ', 'Làm đẹp', 'Trang điểm',
  'Chăm sóc da', 'Chăm sóc tóc', 'Nails', 'Chó', 'Mèo', 'Rap', 'Ngôn ngữ', 'Chơi guitar',
  'Cosplay', 'Múa cột', 'Hát', 'Vũ đạo', 'Kịch', 'Điện ảnh', 'Handmade', 'Đan len',
  'Đua xe', 'Đố vui', 'Khám phá', 'Tâm linh', 'Phong thủy', 'Tâm lý học', 'Lịch sử',
  'Kể chuyện', 'Sáng tác', 'Viết blog'
];

class AddHobbies extends StatefulWidget {
  const AddHobbies({Key? key}) : super(key: key);

  @override
  State<AddHobbies> createState() => _AddHobbiesState();
}

class _AddHobbiesState extends State<AddHobbies> {
  List<String> selectedHobbies = []; // Danh sách sở thích được chọn

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Row(
        children: const [
          Icon(Icons.add),
          Text('Add hobbies'),
        ],
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: const Text('Add hobbies')),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(child: Text('Chọn sở thích bạn muốn')),
                    const SizedBox(height: 8),
                    Divider(),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: hobbiesList.map((hobby) {
                        return FilterChip(
                          label: Text(hobby),
                          selected: selectedHobbies.contains(hobby),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedHobbies.add(hobby); // Thêm sở thích được chọn vào danh sách
                              } else {
                                selectedHobbies.remove(hobby); // Xóa sở thích không được chọn khỏi danh sách
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
