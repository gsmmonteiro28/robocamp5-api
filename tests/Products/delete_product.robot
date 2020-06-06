***Settings***
Documentation           DELETE /PRODUCT/:id
...                     Deletar produtos cosumindo API

Resource            ../../resources/services.robot

Suite Setup         Set Suite Var Auth Token     ${user_email}    ${user_pass}



***Test Cases***
Delete products
    [Tags]      Sucesso
    ${product}=         Get Json        delete.json
    ${unique}=          Post Product    ${product}      ${token}    before_remove

    ${id}=              Convert To String       ${unique.json()['id']}
    
    ${resp}=            Delete Product     ${id}
    
    Status Should Be    204     ${resp}
  
Product Not Found
    [tags]      Not Found
    ${resp}=            Delete Product     000
    Status Should Be    404     ${resp}
   