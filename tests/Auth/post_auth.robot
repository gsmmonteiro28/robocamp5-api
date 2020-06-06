***Settings***
Documentation           POST /AUTH
...                     Teste de serviço de autorização (Autentication Token)

Resource            ../../resources/services.robot



***Test Cases***
Successfuly Login
    [Tags]          Todo

    ${payload}          Get Json  ????.json
    
    ${resp}=            Post Product  ${payload}   ${token}     before_remove
    Status Should Be    200     ${resp}

Incorrect Password
    [Tags]          Todo

    ${payload}          Get Json  ????.json
    
    ${resp}=            Post Product  ${payload}   ${token}     before_remove
    Status Should Be    200     ${resp}

