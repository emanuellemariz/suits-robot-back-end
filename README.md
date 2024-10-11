
# Testes de API - Funcionalidade Company

Este repositório contém testes automatizados para a funcionalidade **Company** de uma API, utilizando o **Robot Framework**. Os testes cobrem diferentes endpoints e funcionalidades relacionados a empresas, garantindo a integridade e o correto funcionamento da API.

## Estrutura do Projeto

- **/tests**: Contém os arquivos de teste escritos no formato do Robot Framework.
- **/resources**: Inclui arquivos de suporte, como variáveis, configurações e dados de teste.
- **/keywords**: Contém as keywords customizadas utilizadas nos testes, escritas em Robot Framework ou Python.

## Pré-requisitos

Antes de rodar os testes, certifique-se de que tem as seguintes ferramentas instaladas:

- [Python 3.x](https://www.python.org/downloads/)
- [Robot Framework](https://robotframework.org/)
- [Requests Library para Robot Framework](https://marketsquare.github.io/robotframework-requests/)
- [JSONLibrary para Robot Framework](https://github.com/robotframework-thailand/robotframework-jsonlibrary)

Para instalar as dependências:

```bash
pip install robotframework
pip install robotframework-requests
pip install robotframework-jsonlibrary
```

### Executando os Testes

Para executar todos os testes:

```bash
robot -d ./results tests/
```
