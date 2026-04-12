import 'package:flutter_test/flutter_test.dart';
import 'package:amago/app/features/data/models/post_model.dart';
import 'package:amago/app/features/data/models/user_summary_model.dart';

void main() {
  group("PostModel", () {
    group(' FromMap', () {
      test('deve retornar PostModel quando o map for válido', () {
        final map = {
          'id': '1',
          'title': 'Título',
          'description': 'Descrição',
          'postType': 'IMAGE',
          'file': 'file.png',
          'createdAt': '2025-01-01',
          'updateAt': '2025-01-02',
          'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
        };

        final result = PostModel.fromMap(map);

        expect(result.id, '1');
        expect(result.title, 'Título');
        expect(result.description, 'Descrição');
        expect(result.postType, 'IMAGE');
        expect(result.file, 'file.png');
        expect(result.createdAt, '2025-01-01');
        expect(result.updateAt, '2025-01-02');

        expect(result.user, isA<UserSummaryModel>());
        expect(result.user.id, '10');
        expect(result.user.name, 'Lázaro');
      });

      test(
        'deve retornar PostModel com campos opcionais nulos quando não forem informados',
        () {
          final map = {
            'id': '1',
            'title': 'Título',
            'description': 'Descrição',
            'postType': 'TEXT',
            'createdAt': '2025-01-01',
            'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
          };

          final result = PostModel.fromMap(map);

          expect(result.file, null);
          expect(result.updateAt, null);
        },
      );

      test('deve lançar erro quando campo obrigatório estiver ausente', () {
        final map = {'title': 'Título'};

        expect(() => PostModel.fromMap(map), throwsA(isA<TypeError>()));
      });

      test('deve lançar erro quando tipo de campo estiver incorreto', () {
        final map = {
          'id': 123,
          'title': 'Título',
          'description': 'Descrição',
          'postType': 'TEXT',
          'createdAt': '2025-01-01',
          'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
        };

        expect(() => PostModel.fromMap(map), throwsA(isA<TypeError>()));
      });

      test('deve converter corretamente o userSummary aninhado', () {
        final map = {
          'id': '1',
          'title': 'Título',
          'description': 'Descrição',
          'postType': 'TEXT',
          'createdAt': '2025-01-01',
          'user': {'id': '10', 'name': 'Lázaro'},
        };

        final result = PostModel.fromMap(map);

        expect(result.user, isNotNull);
        expect(result.user.id, '10');
        expect(result.user.name, 'Lázaro');
        expect(result.user.image, null);
      });
    });

    group('ToMap', () {
      test('deve retornar um map válido a partir do PostModel', () {
        final model = PostModel(
          id: '1',
          title: 'Título',
          description: 'Descrição',
          postType: 'IMAGE',
          file: 'file.png',
          createdAt: '2025-01-01',
          updateAt: '2025-01-02',
          user: UserSummaryModel(id: '10', name: 'Lázaro', image: 'img.png'),
        );

        final map = model.toMap();

        expect(map['id'], '1');
        expect(map['title'], 'Título');
        expect(map['description'], 'Descrição');
        expect(map['postType'], 'IMAGE');
        expect(map['file'], 'file.png');
        expect(map['createdAt'], '2025-01-01');
        expect(map['updateAt'], '2025-01-02');
        expect(map['user'], {'id': '10', 'name': 'Lázaro', 'image': 'img.png'});
      });

      test(
        'deve retornar campos opcionais nulos no map quando não estiverem definidos',
        () {
          final model = PostModel(
            id: '1',
            title: 'Título',
            postType: 'TEXT',
            user: UserSummaryModel(id: '1', name: 'name'),
            description: 'Descrição',
            createdAt: '2025-01-01',
          );

          final map = model.toMap();

          expect(map['file'], null);
          expect(map['updateAt'], null);
          expect(map['user']['image'], null);
        },
      );
    });

    group('Consistência', () {
      test(
        'deve manter consistência ao converter de map para model e de volta para map',
        () {
          final map = {
            'id': '1',
            'title': 'Título',
            'description': 'Descrição',
            'postType': 'TEXT',
            'createdAt': '2025-01-01',
            'user': {'id': '10', 'name': 'Lázaro', 'image': 'img.png'},
          };

          final model = PostModel.fromMap(map);
          final result = model.toMap();

          expect(result['id'], map['id']);
          expect(result['title'], map['title']);
          expect(result['description'], map['description']);
          expect(result['createdAt'], map['createdAt']);
          expect(result['postType'], map['postType']);
          expect(result['user'], map['user']);
        },
      );
    });
  });
}
