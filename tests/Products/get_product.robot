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
   