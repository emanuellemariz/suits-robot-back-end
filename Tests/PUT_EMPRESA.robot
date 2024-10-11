*** Settings ***
Documentation        Testes funcionais positivos e negativos para a funcionalidade de Editar os dados de uma Empresa

Resource    ../Keywords/put_empresa.robot

Suite Setup    Setup

*** Test Cases ***
Test1
    Editar cadastro de empresa com sucesso
Test2
    Editar nome de empresa vazio
Test3
    Editar nome de empresa com caractere especial
Test4
    Editar nome de empresa com 100 caracteres
Test5
    Editar nome de empresa com 101 caracteres
Test6
    Get nome/cnpj/matriz de empresa existente
    Editar nome de empresa com nome já utilizado
Test7
    Editar CNPJ de empresa vazio
Test8
    Editar CNPJ com caracteres especiais
Test9
    Editar CNPJ com 13 algarismos
Test10
    Editar CNPJ com 15 algarismos
Test11
    Get nome/cnpj/matriz de empresa existente
    Editar CNPJ de empresa com CNPJ já utilizado
Test12
    Editar Razão Social de empresa vazio
Test13
    Get nome/cnpj/matriz de empresa existente
    Editar Razão Social de empresa com Razão Social já utilizada
Test14
    Editar Razão Social de empresa com caracteres especiais
Test15
    Editar contato responsável de empresa vazio
Test16
    Editar contato responsável com apenas uma palavra
Test17
    Editar contato responsável com 100 caracteres
Test18
    Editar contato responsável com 101 caracteres
Test19
    Editar contato responsável com algarismos
Test20
    Editar Telefone de empresa vazio
Test21
    Editar Telefone com 15 algarismos
Test22
    Editar Telefone com 16 algarismos
Test23
    Editar Telefone com letras e caracteres especiais
Test24
    Editar Email de empresa vazio
Test25
    Editar Email com formato inválido - 1
Test26
    Editar Email com formato inválido - 2
Test27
    Editar Email com formato inválido - 3
Test28
    Editar descrição de empresa com descrição vazia
Test29
    Editar descrição com caracteres especiais