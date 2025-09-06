*** Settings ***
Documentation       To Validate the login form

Library             Collections
Library             SeleniumLibrary
Resource            resource.robot

Test Setup          Open The Browser With Mortgage Payment URL
Test Teardown       Close Browser Session


*** Variables ***
${LINK_CSS}         css:.blinkingText
${PAGE2_XPATH}      xpath://h1[normalize-space()='Documents request']
${BANNER_XPATH}     //p[@class='im-para red']


*** Test Cases ***
Validate Child Window Functionality
    [Documentation]    Validates that the child window opens correctly after selecting the 'User Admin' option during login.
    Select The Link Of Child Window
    Verify The User Is Switched To Child Window
    Grab The Email Id From The Child Window
    Switch To Parent Window And Enter The Email Id


*** Keywords ***
Select The Link Of Child Window
    Click Element    ${LINK_CSS}
    Sleep    5

Verify The User Is Switched To Child Window
    Switch Window    NEW
    Element Text Should Be    ${PAGE2_XPATH}    Documents request

Grab The Email Id From The Child Window
    ${text}=    Get Text    ${BANNER_XPATH}
    Log    ${text}
    ${email}=    Split String    ${text}    at
    Log    ${email[1]}
    ${email_id}=    Split String    ${email[1]}    to
    Log    ${email_id[0]}
    RETURN    ${email_id[0]}
