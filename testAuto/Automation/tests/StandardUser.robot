*** Settings ***
Suite Teardown    # Close Browser
Resource          ../Resources/Common.robot

*** Test Cases ***
Verify Login is successful
    Login    standard_user    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s

Verfication of Waring message for incorrect username
    Login    standard_user_error    ${PASSWORD}
    ${errormsg}    Get Text    //body/div[@id='root']/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/div[3]/h3[1]
    Should Contain    ${errormsg}    Username and password do not match    ignore_case=true

Verification of warning message for incorrect password
    Login    standard_user_error    ${PASSWORD}_error
    ${errormsg}    Get Text    //body/div[@id='root']/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/div[3]/h3[1]
    Should Contain    ${errormsg}    Username and password do not match    ignore_case=true

Purchase mulitple product/products successfully
    Set Log Level    TRACE
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    ${USERNAME}    ${PASSWORD}
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Cart Verification of Products    ${PRODUCT_LIST}    ${productsprice}
    Enter Check Out Info    ${FIRSTNAME}    ${LASTNAME}    ${ZIPCODE}
    Verify Final Price    ${productsprice}
    Place Order

Verify logout is successfull after login
    Login    standard_user    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    Logout

Remove Item from Cart
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    ${USERNAME}    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Remove from Cart    ${PRODUCT_LIST}
    Logout

Firstname field under "Checkout: Your Information" are mandatory
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    ${USERNAME}    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Cart Verification of Products    ${PRODUCT_LIST}    ${productsprice}
    Enter Check Out Info    ${EMPTY}    ${LASTNAME}    ${ZIPCODE}
    ${errormsg}    Get Text    ${CUST_INFO_ERROR_MSG_LOC}
    Should Contain    ${errormsg}    Error: First Name is required    ignore_case=true
    Logout

Lastname field under "Checkout: Your Information" are mandatory
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    ${USERNAME}    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Cart Verification of Products    ${PRODUCT_LIST}    ${productsprice}
    Enter Check Out Info    ${FIRSTNAME}    ${EMPTY}    ${ZIPCODE}
    ${errormsg}    Get Text    ${CUST_INFO_ERROR_MSG_LOC}
    Should Contain    ${errormsg}    Error: First Name is required    ignore_case=true
    Logout

postalcode field under "Checkout: Your Information" are mandatory
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    ${USERNAME}    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Cart Verification of Products    ${PRODUCT_LIST}    ${productsprice}
    Enter Check Out Info    ${FIRSTNAME}    ${LASTNAME}    ${EMPTY}
    ${errormsg}    Get Text    ${CUST_INFO_ERROR_MSG_LOC}
    Should Contain    ${errormsg}    Error: First Name is required    ignore_case=true
    Logout
