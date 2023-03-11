# Minhas Financias

Um Projeto para acompanhar seus ativos e proventos.

## Funcionalidades

- Cadastrar movimentações(compra, venda, grupamento) das ações;
- Ver preços médios e total investido atualizados;
- Importar o extrato do site B3;

### Funcionalidades para serem desenvolvidas

- Cadastrar proventos(JCP e dividendos);
- Preço da ação no mercado;
- Próximos dividendos que irá receber;
- Exportar preencher o IRPF;

Deseja uma nova funcionalidade, que não estaje listada?

Abra uma [issue](https://github.com/LukasPol/my-finances/issues/new)


## Parte Técnica

### Dependências

- Ruby v3.1.2
- Rails v7.0.3
- Postgresql v^12

### Dando Start

1. `git clone git@github.com:LukasPol/my-finances.git`
2. `cd my-finances`
3. `cp .env.sample .env` (copiando as variáveis de ambiente)
4. Troque as  variáveis no arquivo .env
5. `rake db:setup`
6. `./bin/dev`


### Rodando os testes

`rspec spec`