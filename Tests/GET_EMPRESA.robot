*** Settings ***
Documentation    Teste para consultar empresa buscando pelo ID

Resource    ../Keywords/get_empresa.robot

Suite Setup    Pre Test


*** Test Cases ***
Get Company By ID
    Get company by Company ID