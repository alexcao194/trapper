import 'package:flutter/material.dart';

const List<String> locations = <String>['An Giang', 'Bà Rịa - Vũng Tàu', 'Bắc Giang', 'Bắc Kạn',
  'Bạc Liêu', 'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương', 'Bình Phước', 'Bình Thuận',
  'Cà Mau', 'Cao Bằng', 'Cần Thơ', 'Đà Nẵng', 'Đắk Lắk', 'Đắk Nông', 'Điện Biên', 'Đồng Nai',
  'Đồng Tháp', 'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Nội', 'Hà Tĩnh', 'Hải Dương', 'Hải Phòng',
  'Hậu Giang', 'Hòa Bình', 'Hồ Chí Minh', 'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum',
  'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình',
  'Ninh Thuận', 'Phú Thọ', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị',
  'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên Huế',
  'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái', 'Phú Yên', 'Đắk Nông', 'Hậu Giang',
];
class LocationDropDown extends StatefulWidget {
  const LocationDropDown({super.key});

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  String dropdownValue = 'Tỉnh/thành phố';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16 ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: DropdownButton(
        menuMaxHeight: 300,
        borderRadius: BorderRadius.circular(8),
        dropdownColor: Theme.of(context).colorScheme.inversePrimary,
        hint: Text(dropdownValue),
        icon: Icon(Icons.location_city, color: Theme.of(context).colorScheme.primary),
        items: [
          for (var item in locations)
            DropdownMenuItem(
              child: Row(
                children: [
                  Text(item),
                  SizedBox(width: 8),
                ],
              ),
              value: item,
            )
        ],
        onChanged: (value) {
          setState(() {
            dropdownValue = value.toString();
          });
        },
      ),
    );
  }

}
