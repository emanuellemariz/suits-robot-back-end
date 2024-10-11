*** Settings ***

Resource    ../Resources/resource.robot

*** Variables ***
${baseURL}    https://suits.qacoders.dev.br/api
${TOKEN}    EMPTY
${ID}    EMPTY
${NAME}    EMPTY

*** Keywords ***
Pre Test
    Create new session
    Login Admin
    Get ID

Create new session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseURL}    headers=${headers}    verify=true

Login Admin
    ${body}    Create Dictionary
    ...    mail=sysadmin@qacoders.com    
    ...    password=1234@Test
    
    Create new session
    ${response}    POST On Session    alias=develop    url=/login    json=${body}
    Set Global Variable    ${TOKEN}    ${response.json()["token"]}

Get ID
    ${response}    GET On Session    alias=develop    url=/company/?token=${TOKEN}
    Set Global Variable    ${ID}    ${response.json()[1]}[_id]
    Set Global Variable    ${NAME}    ${response.json()[1]}[corporateName]

Get company by Company ID
    ${response}    GET On Session    alias=develop    url=company/${ID}?token=${TOKEN}
    Status Should Be    200    
    Should Be Equal    ${NAME}    ${response.json()["corporateName"]}
