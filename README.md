# Âmago

O Âmago é uma rede social criada para compartilhar memórias de momentos íntimos já vividos, despertando aquele gostinho do passado, profundo e marcante, que merece ser revivido mais uma vez.

O projeto, antes chamado de *Pulse Post*, foi refatorado para que o aplicativo não seja apenas uma rede social de criação de posts, mas uma plataforma que traga mais significado aos usuários, priorizando práticas de gestão de projeto, qualidade de software, uso de IA e clareza arquitetural.

Ao explorar as branches do repositório, é possível acompanhar a evolução do sistema e entender as decisões técnicas adotadas ao longo do desenvolvimento.

## Tecnologias e Abordagens

O aplicativo foi desenvolvido seguindo os princípios da Clean Architecture, promovendo separação clara de responsabilidades, baixo acoplamento e alta testabilidade.

Para o gerenciamento de estado, foi utilizado o MobX, enquanto o GetIt foi adotado como gerenciador de dependências, promovendo modularidade e desacoplamento.

Para comunicação com o backend (desenvolvido em Spring Boot), utilizei o Dio como cliente HTTP. Os arquivos de mídia (imagens e vídeos) são armazenados no Cloudinary, garantindo eficiência e escalabilidade.

O projeto permite que o usuário:

Tire fotos diretamente com a câmera do smartphone Android
Faça upload de imagens e vídeos armazenados localmente no dispositivo

A navegação entre telas é gerenciada com o GoRouter, proporcionando uma estrutura de rotas organizada e previsível. Para a persistência segura de dados sensíveis, foi utilizado o Flutter Secure Storage.

Além disso, o Envied foi empregado para proteger informações sensíveis, como a baseUrl do backend. O projeto também conta com validações aplicadas nos controllers e por meio de Validators, garantindo maior confiabilidade dos dados.

Por fim, foi desenvolvida uma UI Kit própria, seguindo a metodologia Atomic Design, com foco na reutilização de componentes e padronização visual.

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

