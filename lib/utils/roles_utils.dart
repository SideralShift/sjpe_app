import 'package:app/models/department.dart';
import 'package:app/models/role.dart';

class RolesUtil {
  static final _rolesList = {
    0: Role(id: 1, description: 'PRESIDENTE', department: Department(id: 1)),
    1: Role(
        id: 2, description: 'VICEPRESIDENTE', department: Department(id: 1)),
    2: Role(id: 3, description: 'SECRETARIO', department: Department(id: 1)),
    3: Role(id: 4, description: 'SUBSECRETARIO', department: Department(id: 1)),
    4: Role(id: 5, description: 'TESORERO', department: Department(id: 1)),
    5: Role(id: 6, description: 'SUBTESORERO', department: Department(id: 1)),
    6: Role(id: 8, description: 'DONATIVOS', department: Department(id: 2)),
    7: Role(id: 11, description: 'EVANGELISMO', department: Department(id: 2)),
    8: Role(id: 15, description: 'GPO. EXTRA', department: Department(id: 4)),
    9: Role(id: 16, description: 'ASEO', department: Department(id: 4)),
    10: Role(
        id: 7, description: 'PRO-ANIVERSARIO', department: Department(id: 2)),
    11: Role(id: 9, description: 'AUXILIOS', department: Department(id: 2)),
    12: Role(id: 10, description: 'VIGILANCIA', department: Department(id: 2)),
    13: Role(id: 12, description: 'LIDER', department: Department(id: 3)),
    14: Role(id: 13, description: 'COLIDER', department: Department(id: 3)),
    15: Role(id: 14, description: 'JOVEN', department: Department(id: 3)),
  };

  static Role? getCommissionByIndex(int index) {
    int count = 0; // Indexing from 0 for consistency with Dart's 0-based index
    for (var role in _rolesList.values) {
      if (role.department.id == 2 || role.department.id == 4) {
        if (count == index) {
          return role;
        }
        count++;
      }
    }
    return null;
  }

  static Role? findRoleById(int roleId) {
    try {
      return _rolesList.values.firstWhere((role) => role.id == roleId);
    } catch (e) {
      // Handle the exception or return null
      return null;
    }
  }
}
