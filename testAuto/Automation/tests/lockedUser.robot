*** Settings ***
Resource          ../Resources/Common.robot

*** Test Cases ***
Login denied to locked user
    ${lockeduser}    Set Variable    locked_out_user
    Login    ${lockeduser}    ${PASSWORD}
    ${errormsg}    Get Text    //body/div[@id='root']/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/div[3]/h3[1]
    Should Contain    ${errormsg}    Username and password do not match    ignore_case=true
