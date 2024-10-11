*** Settings ***

Resource    ../Resources/resource.robot

*** Variables ***
${baseURL}    https://suits.qacoders.dev.br/api

*** Keywords ***
Create new session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseURL}    headers=${headers}    verify=true

Login Admin
    ${body}    Create Dictionary    
    ...    mail=sysadmin@qacoders.com    
    ...    password=1234@Test
    Create new session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    ${response}    POST On Session    alias=develop    url=/login    json=${body} 

    RETURN    ${response.json()["token"]}

Create New Company
    ${bodyText}    Get File    ./Tests/company-RequestBody.json

    ${token}    Login Admin
    Set Global Variable    ${token}
    ${response}    POST On Session    alias=develop    url=/company/?token=${token}    data=${bodyText}

    RETURN    ${response.json()["newCompany"]["_id"]}

Delete Company
    ${_id}    Create New Company
    ${response}    DELETE On Session    alias=develop    url=/company/${_id}?token=${token}

    Status Should Be    200    ${response}
