import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_post/app/features/data/models/user_model.dart';

void main() {
  group("UserModel", () {
    group('FromMap', () {
      test('deve retornar UserModel quando o map for válido', () {
        final map = {
          'id': '1',
          'name': 'Lázaro',
          'email': 'email@test.com',
          'bio': 'bio',
          'image': 'img.png',
          'createdAt': '2025-01-01',
          'updatedAt': '2025-01-02',
        };

        final result = UserModel.fromMap(map);

        expect(result.id, '1');
        expect(result.name, 'Lázaro');
        expect(result.email, 'email@test.com');
        expect(result.bio, 'bio');
        expect(result.image, 'img.png');
        expect(result.createdAt, '2025-01-01');
        expect(result.updatedAt, '2025-01-02');
      });

      test(
        'deve retornar UserModel com campos opcionais nulos quando não forem informados',
        () {
          final map = {
            'id': '1',
            'name': 'Lázaro',
            'email': 'email@test.com',
            'createdAt': '2025-01-01',
          };

          final result = UserModel.fromMap(map);

          expect(result.bio, null);
          expect(result.image, null);
          expect(result.updatedAt, null);
        },
      );

      test('deve lançar erro quando campo obrigatório estiver ausente', () {
        final map = {'name': 'Lázaro'};

        expect(() => UserModel.fromMap(map), throwsA(isA<TypeError>()));
      });

      test('deve lançar erro quando tipo de campo estiver incorreto', () {
        final map = {
          'id': 123,
          'name': 'Lázaro',
          'email': 'email@test.com',
          'createdAt': '2025-01-01',
        };

        expect(() => UserModel.fromMap(map), throwsA(isA<TypeError>()));
      });
    });

    group('ToMap', () {
      test('deve retornar um map válido a partir do UserModel', () {
        final model = UserModel(
          id: '1',
          name: 'Lázaro',
          email: 'email@test.com',
          bio: 'bio',
          image: 'img.png',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-02',
        );

        final map = model.toMap();

        expect(map['id'], '1');
        expect(map['name'], 'Lázaro');
        expect(map['email'], 'email@test.com');
        expect(map['bio'], 'bio');
        expect(map['image'], 'img.png');
        expect(map['createdAt'], '2025-01-01');
        expect(map['updatedAt'], '2025-01-02');
      });
    });

    group('Consistência', () {
      test(
        'deve manter consistência ao converter de map para model e de volta para map',
        () {
          final map = {
            'id': '1',
            'name': 'Lázaro',
            'email': 'email@test.com',
            'createdAt': '2025-01-01',
          };

          final model = UserModel.fromMap(map);
          final result = model.toMap();

          expect(result['id'], map['id']);
          expect(result['name'], map['name']);
          expect(result['email'], map['email']);
          expect(result['createdAt'], map['createdAt']);
        },
      );
    });
  });
}
