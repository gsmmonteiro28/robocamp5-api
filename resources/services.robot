***Settings***
Documentation           Chamadas de serviços emcapsuladas


Library             RequestsLibrary
Library             libs/database.py
Library             Collections

Resource            helpers.robot

***Variables***
${base_url}     http://pixel-api:3333
${user_email}   papito@ninjapixel.com
${user_pass}    pwd123


***Keywords***
Set Suite Var Auth Token
    [Arguments]     ${email}    ${password}

    Create Session      pixel   ${base_url}

    &{headers_token}=   Create Dictionary   Content-Type=application/json
    &{payload_token}=   Create Dictionary   email=${email}   password=${password}

    ${resp}=            post Request    pixel   /Auth       data=&{payload_token}    headers=${headers_token}

    ${token}            Convert To String   JWT ${resp.json()['token']}

   ## Outra forma de fazer o token
   # [Return]            ${token}

    Set Suite Variable      ${token}

Post Product
    [Arguments]         ${payload}  ${token}    ${remove}

    ## utilização do If com validação do conteuda da variável (Usar raramente!!!!!!)
    Run Keyword If     "${remove}" == "before_remove"
    ...                 Remove Product By Title     ${payload['title']}

    Create Session      pixel               ${base_url}
    &{headers}=         Create Dictionary   Authorization=${token}      Content-Type=application/json
    
    ${resp}=            post Request    pixel     /products       data=${payload}   headers=${headers}

    [Return]             ${resp}

Get Product
    [Arguments]         ${id}

    Create Session      pixel               ${base_url}
    &{headers}=         Create Dictionary   Authorization=${token}      Content-Type=application/json
    
    ${resp}=            Get Request    pixel     /products/${id}       headers=${headers}

    [Return]             ${resp}

Get Products
    Create Session      pixel               ${base_url}
    &{headers}=         Create Dictionary   Authorization=${token}      Content-Type=application/json
    
    ${resp}=            Get Request    pixel     /products       headers=${headers}

    [Return]             ${resp}

Delete Product
    [Arguments]         ${id}

    Create Session      pixel               ${base_url}
    &{headers}=         Create Dictionary   Authorization=${token}      Content-Type=application/json
    
    ${resp}=            Delete Request    pixel     /products/${id}       headers=${headers}

    [Return]             ${resp}