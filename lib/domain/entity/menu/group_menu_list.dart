import 'menu.dart';
import 'menu_list.dart';

class GroupMenuList extends MenuList {
  String groupName;

  GroupMenuList({
    required List<Menu> menuContentList,
    required this.groupName
  }) : super(
    menuContentList: menuContentList,
  );
}