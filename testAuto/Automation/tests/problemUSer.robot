*** Settings ***
Resource          ../Resources/Common.robot

*** Test Cases ***
Problem user not able to place the order as Lastname field not editable
    Append to List    ${PRODUCT_LIST}    Sauce Labs Backpack
    Login    problem_user    ${PASSWORD}
    ${productsprice}    Add Product to Cart    ${PRODUCT_LIST}
    Click on Cart
    Cart Verification of Products    ${PRODUCT_LIST}    ${productsprice}
    Enter Check Out Info    ${FIRSTNAME}    ${LASTNAME}    ${ZIPCODE}
    ${errormsg}    Get Text    ${CUST_INFO_ERROR_MSG_LOC}
    Should Contain    ${errormsg}    Error: Last Name is required    ignore_case=true
    ${lastnametext}    Get Text    ${LASTNAME_LOC}
    ${output}    Should Be Empty    ${lastnametext}

Incorrect Images visible for products when logged via problem_user
    Login    standard_user    ${PASSWORD}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    //span[contains(text(),'Products')]
    Sleep    2s
    ${correctImage}    Get Element Attribute    //div[@class='inventory_list']/div[@class='inventory_item']/div[1]/a[1]/img[@alt='Sauce Labs Backpack']    src
    log    ${correctImage}
    Logout
    Login    problem_user    ${PASSWORD}
    ${wrongimage}    Get Element Attribute    //div[@class='inventory_list']/div[@class='inventory_item']/div[1]/a[1]/img[@alt='Sauce Labs Backpack']    src
    log    ${wrongimage}
    Should Not Be Equal    ${correctImage}    ${wrongimage}    ignore_case=truw
