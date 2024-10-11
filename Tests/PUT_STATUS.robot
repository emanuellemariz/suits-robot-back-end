*** Settings ***
Documentation    Testes para atualizar o status da empresa

Resource    ../Keywords/put_status.robot

Suite Setup    Autenticação

*** Test Cases ***
Atualizar status para Inativo
    Pegar ID
    Atualizar status para Inativo

Atualizar status para Ativo
    Pegar ID
    Atualizar status para Ativo
