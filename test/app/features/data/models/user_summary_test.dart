import 'package:flutter_test/flutter_test.dart';
import 'package:amago/app/features/data/models/user_summary_model.dart';

void main() {
  group('UserSummaryModel', () {
    group('FromMap', () {
      test('deve retornar UserSummaryModel quando o map for válido', () {
        final map = {'id': '1', 'name': 'Lázaro', 'image': 'img.png'};

        final result = UserSummaryModel.fromMap(map);

        expect(result.id, '1');
        expect(result.name, 'Lázaro');
        expect(result.image, 'img.png');
      });

      test(
        'deve retornar UserSummaryModel com image nulo quando não for informado',
        () {
          final map = {'id': '1', 'name': 'Lázaro'};

          final result = UserSummaryModel.fromMap(map);

          expect(result.image, null);
        },
      );

      test('deve lançar erro quando campo obrigatório estiver ausente', () {
        final map = {'name': 'Lázaro'};

        expect(() => UserSummaryModel.fromMap(map), throwsA(isA<TypeError>()));
      });

      test('deve lançar erro quando tipo de campo estiver incorreto', () {
        final map = {'id': 123, 'name': 'Lázaro'};

        expect(() => UserSummaryModel.fromMap(map), throwsA(isA<TypeError>()));
      });
    });

    group('ToMap', () {
      test('deve retornar um map válido a partir do UserSummaryModel', () {
        final model = UserSummaryModel(
          id: '1',
          name: 'Lázaro',
          image: 'img.png',
        );

        final map = model.toMap();

        expect(map['id'], '1');
        expect(map['name'], 'Lázaro');
        expect(map['image'], 'img.png');
      });

      test('deve retornar image nulo no map quando não estiver definido', () {
        final model = UserSummaryModel(id: '1', name: 'Lázaro');

        final map = model.toMap();

        expect(map['image'], null);
      });
    });

    group('Consistência', () {
      test(
        'deve manter consistência ao converter de map para model e de volta para map',
        () {
          final map = {'id': '1', 'name': 'Lázaro', 'image': 'img.png'};

          final model = UserSummaryModel.fromMap(map);
          final result = model.toMap();

          expect(result['id'], map['id']);
          expect(result['name'], map['name']);
          expect(result['image'], map['image']);
        },
      );
    });
  });
}
