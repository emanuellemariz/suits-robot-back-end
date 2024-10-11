*** Settings ***

Resource    ../Resources/resource.robot
Resource    ../Resources/keywords_gerar_massa.robot

*** Variables ***
${baseURL}    https://suits.qacoders.dev.br/api
${company-Body_FILE}    ${CURDIR}${/}..${/}Tests${/}updateCompany-Body.json
${TOKEN}    EMPTY
${COMPANY_ID}    EMPTY
${NOME_PRIMEIRA}    EMPTY
${CNPJ_PRIMEIRA}    EMPTY
${MATRIZ_PRIMEIRA}    EMPTY

*** Keywords ***
Setup
    Create new session
    Login Admin
    Create new company

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

Create new company
    ${companyName}    gerar_nome_aleatorio
    ${cnpj}    gerar_cnpj
    ${email}    gerar_email_aleatorio
    ${address}    Create Dictionary     zipCode=04777001    city=São Paulo    state=SP    district=Rua das Flores    street=Avenida Interlagos    number=50    complement=de 4503 ao fim - lado ímpar    country=Brasil
    ${address}    Create List    ${address}

    ${body}    Create Dictionary    corporateName=${companyName}    registerCompany=${cnpj}    mail=${email}
    ...    matriz=Testes    responsibleContact=Marcio    telephone=99999999999999    serviceDescription=Testes
    ...    address=${address}
    
    ${response}    POST On Session    alias=develop    url=/company/?token=${TOKEN}    json=${body}    expected_status=201

    Set Global Variable    ${COMPANY_ID}    ${response.json()["newCompany"]["_id"]}

Get nome/cnpj/matriz de empresa existente
    ${response}    GET On Session    alias=develop    url=/company/?token=${TOKEN}
    Set Global Variable    ${NOME_PRIMEIRA}    ${response.json()[0]}[corporateName]
    Set Global Variable    ${CNPJ_PRIMEIRA}    ${response.json()[0]}[registerCompany]
    Set Global Variable    ${MATRIZ_PRIMEIRA}    ${response.json()[0]}[matriz]

Editar cadastro de empresa com sucesso
    ${body}    Load Json From File    ${company-Body_FILE}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=201
    Should Be Equal    Companhia atualizada com sucesso.    ${response.json()["msg"]}

Editar nome de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.corporateName    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar nome de empresa com caractere especial
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.corporateName    Empres@ Tes!$E
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar nome de empresa com 100 caracteres
    ${nome_100char}    gerar_nome_100char
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.corporateName    ${nome_100char}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=201

Editar nome de empresa com 101 caracteres
    ${nome_101char}    gerar_nome_101char
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.corporateName    ${nome_101char}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar nome de empresa com nome já utilizado
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.corporateName    ${NOME_PRIMEIRA}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar CNPJ de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.registerCompany    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar CNPJ com caracteres especiais
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.registerCompany    999.999*9999@9
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar CNPJ com 13 algarismos
    ${cnpj_13num}    gerar_cnpj_13num
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.registerCompany    ${cnpj_13num}
    ${response}    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar CNPJ com 15 algarismos
    ${cnpj_15num}    gerar_cnpj_15num
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.registerCompany    ${cnpj_15num}
    ${response}    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar CNPJ de empresa com CNPJ já utilizado
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.registerCompany    ${CNPJ_PRIMEIRA}
    ${response}    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Razão Social de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.matriz    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Razão Social de empresa com Razão Social já utilizada
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.matriz    ${MATRIZ_PRIMEIRA}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Razão Social de empresa com caracteres especiais
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.matriz    Te$t@es!
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar contato responsável de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.responsibleContact    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar contato responsável com apenas uma palavra
    ${palavra}    gerar_palavra
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.responsibleContact    ${palavra}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar contato responsável com 100 caracteres
    ${nome_100char}    gerar_nome_100char
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.responsibleContact    ${nome_100char}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=201

Editar contato responsável com 101 caracteres
    ${nome_101char}    gerar_nome_101char
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.responsibleContact    ${nome_101char}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar contato responsável com algarismos
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.responsibleContact    Nom3 N0m35
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Telefone de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.telephone    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Telefone com 15 algarismos
    ${telefone}    gerar_telefone_15num
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.telephone    ${telefone}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=201

Editar Telefone com 16 algarismos
    ${telefone}    gerar_telefone_16num
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.telephone    ${telefone}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Telefone com letras e caracteres especiais
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.telephone    9a99b9*9.99/99
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Email de empresa vazio
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.mail    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Email com formato inválido - 1
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.mail    @gmail.com
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Email com formato inválido - 2
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.mail    teste123@
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar Email com formato inválido - 3
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.mail    teste123@gmail
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar descrição de empresa com descrição vazia
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.serviceDescription    ${EMPTY}
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400

Editar descrição com caracteres especiais
    ${body}    Load Json From File    ${company-Body_FILE}
    ${body}    Update Value To Json    ${body}    $.serviceDescription    Tes@#% do Te$%¨&*
    ${response}=    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    expected_status=400
