## Word Puzzle - Projeto de estudo

Jogo desenvolvido em UIKit, onde o usuário precisa formar palavras a partir de blocos de letras com base em dicas.

Este projeto faz parte do curso **100 Days of Swift**, mas foi adaptado com foco em **arquitetura, organização e boas práticas**.

---

## O que o app faz

- Exibe dicas para palavras ocultas  
- Mostra a quantidade de letras de cada resposta  
- Permite montar palavras a partir de blocos de letras  
- Valida respostas corretas, incorretas e duplicadas  
- Atualiza pontuação conforme acertos  
- Avança automaticamente de nível ao completar todas as palavras  

---

## Arquitetura

O projeto foi estruturado utilizando **MVVM**, com separação clara de responsabilidades:

- **ViewController:**  responsável apenas pela UI e interações  
- **ViewModel:** responsável pela lógica do jogo e gerenciamento de estado  

---

## Melhorias em relação ao projeto original

Comparado ao projeto do curso, foram feitas adaptações importantes:

- Separação completa entre UI e lógica  
- Organização por **Features**  
- Remoção de responsabilidades da ViewController  
- Estrutura preparada para crescimento (novos níveis, novas telas)  
- Código mais limpo e legível  
- Tratamento de estados (acerto, erro, duplicado, fim de nível)  


Projeto desenvolvido durante transição de carreira para iOS.
