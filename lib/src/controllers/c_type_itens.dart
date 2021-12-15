import 'package:sdgp/src/connections/connection_database.dart';
import 'package:sdgp/src/models/m_type_item.dart';

class TypeItensController {
  ///Function returns a list of items
  Future<List<TypeItemModel>> getAll() async {
    List<Map<String, dynamic>> map;
    List<TypeItemModel> listTypes = [];
    map = await ConnectionDB().getExecQuery(
        "SELECT * FROM type_Items WHERE status = 1 ORDER BY description ASC");
    for (var item in map) {
      listTypes.add(TypeItemModel.fromJson(item));
    }
    return listTypes;
  }
}
