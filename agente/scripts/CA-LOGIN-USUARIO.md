### Critérios de Aceitação - Login de Usuário

**Dado** que possuo uma conta cadastrada,  
**Quando** informo email e senha corretos na tela de login,  
**Então** o sistema armazena o token JWT e redireciona para a tela Home.  

**Dado** que informo senha incorreta ou email não cadastrado,  
**Quando** tento fazer login,  
**Então** o sistema exibe erro "E-mail ou senha inválidos".  

**Dado** que informo senha com menos de 6 ou mais que 10 caracter,  
**Quando** tento fazer login,  
**Então** o sistema exibe erro "O máximo de caracteres é 10!" ou "O mínimo de caracters é 6!".  

**Dado** que informo uma senha sem ao menos 1 caractere maiúsculo, 1 caractere minúsculo, 1 número e 1 caractere especial,  
**Quando** tento fazer login,  
**Então** o sistema exibe erro "A senha deve conter ao menos 1 caractere maiúsculo, 1 caractere minúsculo, 1 número e 1 caractere especial!". 

**Dado** que tento fazer login sem informar email ou senha,  
**Quando** envio a requisição,  
**Então** o sistema exibe erro de campo obrigatório.