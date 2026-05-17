# Âmago

O Âmago é uma rede social criada para compartilhar memórias de momentos íntimos já vividos, despertando aquele gostinho do passado, profundo e marcante, que merece ser revivido mais uma vez.

O projeto, antes chamado de *Pulse Post*, foi refatorado para que o aplicativo não seja apenas uma rede social de criação de posts, mas uma plataforma que traga mais significado aos usuários, priorizando práticas de gestão de projeto, qualidade de software, uso de IA e clareza arquitetural.

Ao explorar as branches do repositório, é possível acompanhar a evolução do sistema e entender as decisões técnicas adotadas ao longo do desenvolvimento.

## Tecnologias e Abordagens

O aplicativo foi desenvolvido utilizando Flutter e Dart, seguindo os princípios da Clean Architecture, promovendo separação clara de responsabilidades, baixo acoplamento e alta testabilidade.

A arquitetura foi organizada em três camadas principais:

- **Domain** → Contém as regras de negócio, entidades, contratos de repositórios, parâmetros e casos de uso.
- **Data** → Responsável pela comunicação com APIs externas, serialização de dados, mapeamentos e implementação dos contratos de repositório.
- **Presentation** → Responsável pela interface do usuário, gerenciamento de estado, navegação e interação com os controllers.

Para gerenciamento de estado, foi utilizado o MobX, enquanto o GetIt foi adotado para injeção e gerenciamento de dependências.

A comunicação com o backend, desenvolvido em Spring Boot, é realizada por meio do Dio, oferecendo interceptação de requisições, tratamento de erros e maior flexibilidade na camada de rede.

Para navegação entre telas, foi utilizado o GoRouter, proporcionando organização e previsibilidade no fluxo de rotas.

O armazenamento seguro de dados sensíveis, como tokens de autenticação, é realizado com Flutter Secure Storage.

As variáveis de ambiente são protegidas utilizando Envied, permitindo ocultação de informações sensíveis como a URL base da API.

O aplicativo também oferece integração com recursos nativos do Android, permitindo:

- Captura de fotos diretamente pela câmera do dispositivo
- Upload de imagens e vídeos armazenados localmente

Por fim, o projeto tambném conta com uma UI Kit própria seguindo os princípios do **Atomic Design**, promovendo reutilização de componentes, padronização visual e escalabilidade da interface.

## Organização do Projeto

A estrutura do projeto segue os princípios da Clean Architecture:

```text
app/
├── features/
│   ├── domain/
│   │   ├── entities/
│   │   ├── enums/
│   │   ├── params/
│   │   ├── value_objects/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   ├── mappers/
│   │   └── repositories/
│   ├── presentation/
│   │   ├── controllers/
│   │   ├── modules/
│   │   └── viewmodels/
├── core/
│   ├── errors/
│   ├── exceptions/
│   ├── interceptors/
│   ├── services/
│   ├── usecase/
└── └── utils/

```

Essa organização permite que cada funcionalidade evolua de forma independente, mantendo a clareza arquitetural e facilitando a manutenção do código.

## Inicialização

Primeiramente, instale todas as configurações do flutter em sua máquina, caso já não esteja instalada. Siga a documentação: https://docs.flutter.dev/get-started/install

Após isso, copie o arquivo .env.example e cole na raiz do repositório.

Em seguida, renomei o arquivo para .env e adicione a baseURL do backend spring entre as aspas do BASE_URL="...".

Após essa configuração, volte ao projeto e execute os seguintes comandos no terminal:

- flutter clean
- flutter pub get
- dart run build_runner build
- cd uikit/
- flutter clean
- flutter pub get
- cd ..

Conecte o usb do seu disposito android no computador e esolha o dispositivo (Durante a execução do sistema):

- flutter devices

Rode o aplicativo (Durante a execução do sistema):

- flutter run -d nome_do_dispositivo --verbose

