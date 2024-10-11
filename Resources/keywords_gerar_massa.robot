*** Settings ***
Documentation    Arquivo com keywords de geração de massas   
Library    String

*** Keywords ***
gerar_nome_aleatorio
    ${nome1} =     Generate Random String    10    [LETTERS]
    ${nome2} =    Generate Random String    10    [LETTERS]
    ${nome_composto} =    Catenate    ${nome1}    ${nome2}
    ${nome_personalizado} =    Evaluate    "${nome_composto}".title()
    RETURN   ${nome_personalizado}

gerar_cnpj
    ${cnpj}    Generate Random String    14    [NUMBERS]
    RETURN    ${cnpj}

gerar_email_aleatorio
    ${nome} =     Generate Random String    10    [LOWER]
    ${dominio} =    Set Variable    @example.com
    ${email_personalizado} =    Catenate    ${nome}${dominio}
    RETURN    ${email_personalizado}

gerar_nome_100char
    ${nome1} =     Generate Random String    49    [LETTERS]
    ${nome2} =    Generate Random String    50    [LETTERS]
    ${nome_composto} =    Catenate    ${nome1}    ${nome2}
    ${nome_100char} =    Evaluate    "${nome_composto}".title()
    RETURN   ${nome_100char}

gerar_nome_101char
    ${nome1} =     Generate Random String    50    [LETTERS]
    ${nome2} =    Generate Random String    50    [LETTERS]
    ${nome_composto} =    Catenate    ${nome1}    ${nome2}
    ${nome_101char} =    Evaluate    "${nome_composto}".title()
    RETURN   ${nome_101char}

gerar_cnpj_13num
    ${cnpj_13num}    Generate Random String    13    [NUMBERS]
    RETURN    ${cnpj_13num}

gerar_cnpj_15num
    ${cnpj_15num}    Generate Random String    15    [NUMBERS]
    RETURN    ${cnpj_15num}

gerar_palavra
    ${palavra}    Generate Random String    10    [LETTERS]    
    ${palavra}    Evaluate    "${palavra}".title()
    RETURN    ${palavra}

gerar_telefone_15num
    ${telefone}    Generate Random String    15    [NUMBERS]
    RETURN    ${telefone}

gerar_telefone_16num
    ${telefone}    Generate Random String    16    [NUMBERS]
    RETURN    ${telefone}