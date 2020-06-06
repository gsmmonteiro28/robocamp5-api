***Settings***
Documentation           POST /PRODUCT
...                     Teste do cadastro de produtos cosumindo API

Resource            ../../resources/services.robot

Suite Setup         Set Suite Var Auth Token      ${user_email}    ${user_pass}

## Todos os comentários abaixo é pela outra forma de login

***Test Cases***
Create a New Product
#    ${token}            Auth Token  ${user_email}  ${user_pass}
    ${payload}          Get Json  dk2.json
    
    ${resp}=            Post Product  ${payload}   ${token}     before_remove
    Status Should Be    200     ${resp}

Duplicate Product
#    ${token}            Auth Token  ${user_email}  ${user_pass}
    ${payload}          Get Json  duplicate.json
    
    Post Product  ${payload}   ${token}     before_remove
    ${resp}=            Post Product  ${payload}   ${token}     ${empty}
    Status Should Be    409     ${resp}

Empty Title
#    ${token}            Auth Token  ${user_email}  ${user_pass}
    ${payload}          Get Json  empty_title.json
    
    ${resp}=            Post Product  ${payload}   ${token}     ${empty}
    Status Should Be    400     ${resp}

Empty Category
#    ${token}            Auth Token  ${user_email}  ${user_pass}
    ${payload}          Get Json  empty_category.json
    
    ${resp}=            Post Product  ${payload}   ${token}     ${empty}
    Status Should Be    400     ${resp}

Empty Price
#    ${token}            Auth Token  ${user_email}  ${user_pass}
    ${payload}          Get Json  empty_price.json
    
    ${resp}=            Post Product  ${payload}   ${token}     ${empty}
    Status Should Be    400     ${resp}