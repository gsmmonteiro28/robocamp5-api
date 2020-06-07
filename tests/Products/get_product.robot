***Settings***
Documentation           GET /PRODUCT/:id
...                     Consulta de produtos cosumindo API

Resource            ../../resources/services.robot

Suite Setup         Set Suite Var Auth Token     ${user_email}    ${user_pass}



***Test Cases***
Get Unique products
    [Tags]      Sucesso
    ${product}=         Get Json        get_unique.json
    ${unique}=          Post Product    ${product}      ${token}    before_remove

    ${id}=              Convert To String       ${unique.json()['id']}
    
    ${resp}=            Get Product     ${id}
    
    Status Should Be    200     ${resp}
    Should Be Equal     ${resp.json()['title']}    ${product['title']}

Product Not Found
    [tags]      Not Found
    ${resp}=            Get Product     000
    Status Should Be    404     ${resp}
   
Get Product List
    [Tags]      Sucesso

    ${list}=        Get Json        list.json
    ${items}=       Set Variable    ${list['data']}
    
    ##Percorre os itens da lista dentro do data
    FOR     ${item}     IN      @{items}
            Post Product  ${item}      ${token}      before_remove
    END

    ${resp}=        Get Products

    Status Should Be    200     ${resp}
    ##Validar se uma lista não esta vazia
    Should Not Be Empty         ${resp.json()['data']}
    
    ## Validar o tamanho da lista
    ${size}=    Get Length      ${resp.json()['data']}
    Should Be True      ${size} > 0