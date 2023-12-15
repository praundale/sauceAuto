*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Library           DateTime
Resource          Locators.robot

*** Variables ***
${URL}            https://www.saucedemo.com/
${USERNAME}       standard_user
${PASSWORD}       secret_sauce
${BROWSER}        chrome
${FIRSTNAME}      Papa
${LASTNAME}       Romeo
${ZIPCODE}        123456
${TOTAL_PRODUCTS}    6
${PRODUCT_NAME}    Sauce Labs Fleece Jacket
${PRODUCT1}       ${EMPTY}
${PRODUCT2}       ${EMPTY}
${PRODUCT3}       ${EMPTY}
${PRODUCT4}       ${EMPTY}
${PRODUCT5}       ${EMPTY}
${PRODUCT6}       ${EMPTY}
${PRODUCT7}       ${EMPTY}
@{PRODUCT_LIST}

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    ${USERNAME_LOC}
    Input Text    ${USERNAME_LOC}    ${username}
    Input Text    ${PASSWORD_LOC}    ${password}
    Click Button    ${LOGINBUTTON}

Enter Check Out Info
    [Arguments]    ${firstname}    ${lastname}    ${zipcode}
    Input Text    ${FIRSTNAME_LOC}    ${firstname}
    Input Text    ${LASTNAME_LOC}    ${lastname}
    Input Text    ${ZIPCODE_LOC}    ${zipcode}
    Sleep    2s
    Click Button    ${CONTINUE_BUTTON}
    Sleep    2s

Verify Final Price
    [Arguments]    ${pricelist}
    Wait Until Keyword Succeeds    5    1    Element Should Be Visible    ${CHECKOUT_OVERVIEW}
    ${count}    Get Length    ${pricelist}
    ${itemcost}    Set Variable    0
    FOR    ${i}    IN RANGE    ${count}
        ${itemcost}    Evaluate    ${itemcost}+${pricelist}[${i}]
    END
    ${taxvalue}    Evaluate    ${itemcost}*0.08
    ${taxvalue}    Evaluate    "%.2f" % ${taxvalue}
    ${totalCost}    Evaluate    ${itemcost}+${taxvalue}
    ${totalCost}    Convert to String    ${totalCost}
    log    ${totalCost}
    ${total}    Get Text    ${FINALPRICE_LOC}
    Should Contain    ${total}    ${totalCost}    ignore_case=true

Verify Finalprice Details
    [Arguments]    ${noofitems}
    FOR    ${i}    IN RANGE    ${noofitems}
        ${i}    Evaluate    1+${i}
        ${getprice}    Get text    //div[@class='cart_list']/div[@class='cart_item'][${i}]/div[@class='cart_item_label']/div[@class='item_pricebar']/div[@class='inventory_item_price']
        ${getprice}    Convert To Number    ${getprice}
        ${totalprice}    Evaluate    ${totalprice}+${getprice}
    END
    ${taxvalue}    Evaluate    ${totalprice}*0.08
    ${taxvalue}    Evaluate    "%.2f" % ${taxvalue}
    ${finalCost}    Evaluate    ${totalprice}+${taxvalue}
    ${finalCost}    Convert to String    ${finalCost}
    log    ${finalCost}
    ${total}    Get Text    //div[@class='summary_info']/div[@class='summary_info_label summary_total_label']
    Should Contain    ${total}    ${finalCost}    ignore_case=true

Add Product to Cart
    [Arguments]    ${productlist}
    ${productsprice}    Create List
    ${productcount}    Get Length    ${productlist}
    FOR    ${i}    IN RANGE    ${productcount}
        ${productsprice}    Select Products    ${productlist}[${i}]    ${productsprice}
    END
    [Return]    ${productsprice}

Place Order
    Click Button    ${FINISH_BUTTON}
    Wait Until Keyword Succeeds    5    1    Element Should Be Visible    ${THANKYOU_MSG}

Select Products
    [Arguments]    ${prodname}    ${productsprice}
    ${increment_variable}    Set Variable    1
    ${static_variable}    Set Variable    0
    FOR    ${j}    IN RANGE    ${TOTAL_PRODUCTS}
        ${j}    Evaluate    ${j}+${increment_variable}
        ${productnametext}    Get Text    //div[@class='inventory_list']/div[@class='inventory_item'][${j}]/div[2]/div[1]/a[1]/div[1]
        ${productprice}    Run Keyword if    '${productnametext}'=='${prodname}'    Get Text    //div[@class='inventory_list']/div[@class='inventory_item'][${j}]/div[2]/div[2]/div[1]
        ${productprice}    Run Keyword if    '${productnametext}'=='${prodname}'    Remove String    ${productprice}    $
        ${productprice}    Run Keyword if    '${productnametext}'=='${prodname}'    Convert To Number    ${productprice}
        Run Keyword if    '${productnametext}'=='${prodname}'    Append to List    ${productsprice}    ${productprice}
        Run Keyword If    '${productnametext}'=='${prodname}'    Click Button    //div[@class='inventory_list']/div[@class='inventory_item'][${j}]/div[2]/div[2]/button[1]
    END
    [Return]    ${productsprice}

Cart Verification of Products
    [Arguments]    ${productlist}    ${pricelist}
    ${i}    Set Variable    2
    ${productcount}    Get Length    ${productlist}
    FOR    ${j}    IN RANGE    ${productcount}
        ${i}    Evaluate    1+${i}
        ${itemname}    Get Text    //div[@class='cart_list']/div[${i}][1]/div[2]/a[1]/div[1]
        Should Contain    ${itemname}    ${productlist}[${j}]
        ${itemprice}    Get Text    //div[@class='cart_list']/div[${i}][1]/div[2]/div[2]/div[1]
        ${itemprice}    Remove String    ${itemprice}    $
        ${itemprice}    Convert To Number    ${itemprice}
        Should Be Equal As Numbers    ${itemprice}    ${pricelist}[${j}]
    END
    Click Button    ${CHECKOUT_BUTTON}
    Wait Until Keyword Succeeds    5    1    Element Should Be Visible    ${YOURINFO_LOC}

Logout
    Click Button    ${MENU_BUTTON}
    Sleep    2s
    Click Element    ${LOGOUT_BUTTON}
    Wait Until Keyword Succeeds    20    5    Element Should Be Visible    ${HOMEPAGE}

Click on Cart
    Click Element    ${CART_LOCATOR}
    Wait Until Keyword Succeeds    5    1    Element Should Be Visible    ${CARTPAGE_LOC}

Remove from Cart
    [Arguments]    ${productlist}
    ${i}    Set Variable    2
    ${productcount}    Get Length    ${productlist}
    FOR    ${j}    IN RANGE    ${productcount}
        ${i}    Evaluate    1+${i}
        ${itemname}    Get Text    //div[@class='cart_list']/div[${i}][1]/div[2]/div[2]/button[1]
        Should Contain    ${itemname}    ${productlist}[${j}]
    END
