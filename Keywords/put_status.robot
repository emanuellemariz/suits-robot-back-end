*** Settings ***

Resource    ../Resources/resource.robot

*** Variables ***
${baseURL}    https://suits.qacoders.dev.br/api
${TOKEN}    EMPTY
${COMPANY_ID}    EMPTY

*** Keywords ***

Autenticação
    Criar sessão
    Login Admin

Criar sessão
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseURL}    headers=${headers}

Login Admin
    ${body}    Create Dictionary
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test

    ${response}    POST On Session    alias=develop    url=/login    json=${body}
    Set Global Variable    ${TOKEN}    ${response.json()["token"]}
    Should Be Equal    ${TOKEN}    ${response.json()["token"]}

Pegar ID
    ${response}    GET On Session    alias=develop    url=/company/?token=${TOKEN}
    
    Set Global Variable    ${COMPANY_ID}    ${response.json()[0]}[_id]      #pegar o ID do primeiro da lista de Companhias

Atualizar status para Inativo
    ${body}    Create Dictionary    
    ...    status=false
    
    ${response}    PUT On Session    alias=develop    url=/company/status/${COMPANY_ID}?token=${TOKEN}    json=${body}
    Status Should Be    201
    Should Be Equal    ${response.json()["msg"]}    Status da companhia atualizado com sucesso.
    Should Be Equal    ${response.json()["updateCompany"]["status"]}    ${False}

Atualizar status para Ativo
    ${body}    Create Dictionary
    ...    status=true
    
    ${response}    PUT On Session    alias=develop    url=/company/status/${COMPANY_ID}?token=${TOKEN}    json=${body}
    Status Should Be    201
    Should Be Equal    ${response.json()["msg"]}    Status da companhia atualizado com sucesso.
    Should Be Equal    ${response.json()["updateCompany"]["status"]}    ${True}