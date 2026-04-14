# Guilda
Banco de dados relacional em postgres

🎮 SteamDB Clone - Modelagem de Banco de Dados

📌 Sobre o Projeto

Este projeto consiste na modelagem lógica e física de um ecossistema complexo de plataforma de jogos (inspirado na Steam). O objetivo é aplicar conceitos avançados de Banco de Dados para gerenciar desde o cadastro de usuários e biblioteca de jogos até sistemas de mercado de itens e suporte à comunidade.

O domínio foi escolhido pela sua alta complexidade de relacionamentos e pela necessidade de integridade de dados em transações financeiras e sociais.

🏗️ Estrutura do Domínio

A modelagem foi dividida em 6 núcleos principais para garantir a organização e escalabilidade do sistema:

    Núcleo de Usuários: Gestão de perfis, amizades, grupos e segurança.

    Catálogo de Jogos: Informações técnicas, desenvolvedoras, DLCs e requisitos de sistema.

    Loja e Financeiro: Processamento de transações, preços regionais e cupons.

    Biblioteca e Progresso: Histórico de jogo, conquistas e saves em nuvem.

    Inventário e Mercado: Sistema de itens, trocas entre usuários e anúncios.

    Comunidade e Suporte: Avaliações, mods (oficina) e sistema de tickets de suporte.

🗂️ Organização do Repositório
Bash

    ├── /ddl
    │   ├── 01-nucleo-usuarios.sql
    │   ├── 02-catalogo-jogos.sql
    │   ├── 03-loja-financeiro.sql
    │   ├── 04-biblioteca-progresso.sql
    │   ├── 05-inventario-mercado.sql
    │   └── 06-comunidade-suporte.sql
    ├── /docs
    │   └── justificativa-dominio.md
    ├── /dql
    │   ├── consulta_de_conjuntos.sql
    │   ├── consulta_relacional.sql
    │   └── consulta_de_agrupamento.sql
    └── README.md

🛠️ Padrões de Nomenclatura (Naming Standards)

Seguindo as diretrizes do Database Naming Standards, adotamos:

    Tabelas: Nomes em minúsculo e no plural (ex: usuarios).

    Snake Case: Palavras separadas por sublinhado (ex: saldo_carteira).

    Prefixos/Sufixos: Uso de _bool para campos lógicos e _hash para segurança.

🚀 Como Visualizar

Os scripts de criação das tabelas (DDL) estão localizados na pasta /ddl. Eles foram estruturados para serem executados de forma independente nesta fase inicial, focando na definição de atributos e tipos de dados.
Exemplo de Padronização:
SQL


    create table usuarios (
      id int not null,
      email varchar(150) not null,
      senha_hash varchar(255) not null,
      data_criacao datetime not null,
      saldo_carteira decimal(16,2),
      primary key (id)
    );

👥 Equipe e Contribuição

O desenvolvimento deste banco seguiu o fluxo de trabalho colaborativo via Git:

    Branching: Uso de Pull Requests para revisão de código.

    Commits: Mensagens claras e divisão de tarefas por núcleo de tabelas.



Este projeto faz parte da Atividade de Modelagem de Banco de Dados - 2026.
