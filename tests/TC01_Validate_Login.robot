*** Settings ***
Documentation       To Validate the login form

Library             Collections
Library             SeleniumLibrary
Resource            resource.robot

Test Teardown       Close Browser Session


*** Variables ***
${SHOP_PAGE_LOAD}       css:.nav-link
${CARD_XPATH}           (//*[@class='card-footer']/button)['?']


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    Validates that login fails with invalid credentials and displays the correct error message.
    Open The Browser With Mortgage Payment URL
    Fill The Login Form    ${user_name}    ${invalid_password}
    Wait Until Element Is Located In The Page    ${Error_Message_Login}
    Verify Error Message Is Correct

Select The Form And Login By User Admin
    [Documentation]    Fills the login form with valid credentials, selects the 'User Admin' option, and navigates to the child window.
    Open The Browser With Mortgage Payment URL
    Fill The Login Details And Select The User Admin

Validate Cards Displayed In The Shopping Page
    [Documentation]    Validates that cards are displayed correctly in the shopping page after successful login.
    Open The Browser With Mortgage Payment URL
    Fill The Login Form    ${user_name}    ${valid_password}
    Wait Until Element Is Located In The Page    ${shop_page_load}
    Verify Card Titles In The Shop Page
    Select The Card    iphone X
    Sleep    5


*** Keywords ***
Verify Card Titles In The Shop Page
    [Documentation]    Verifies that the card titles are displayed correctly in the shop page.
    @{expectedList}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=    Get WebElements    css:.card-title
    @{actualList}=    Create List
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${actualList}    ${element.text}
    END
    Lists Should Be Equal    ${actualList}    ${expectedList}
    Log    ${actualList}

Select The Card
    [Documentation]    Selects the specified card from the shop page.
    [Arguments]    ${CARD_NAME}

    ${elements}=    Get WebElements    css:.card-title
    ${index}=    Set Variable    1

    FOR    ${element}    IN    @{elements}
        IF    '${CARD_NAME}' == '${element.text}'    BREAK
        ${index}=    Evaluate    ${index} + 1
    END

    ${CARD_XPATH_INDEXED}=    Set Variable    ${CARD_XPATH.replace('?', '{index}')}
    Click Button    xpath:${CARD_XPATH_INDEXED}
    Log    Selected card name is ${CARD_NAME}
    Sleep    5

Fill The Login Details And Select The User Admin
    [Documentation]    Fills the login form with valid credentials and selects the 'User Admin' option.
    Input Text    id:username    rahulshettyacademy
    Input Password    id:password    learning
    Sleep    2
    Click Element    xpath:(//span[@class='checkmark'])[2]
    Wait Until Element Is Visible    css:.modal-body
    Click Element    xpath://button[@id='okayBtn']
    Wait Until Element Is Not Visible    css:.modal-body
    Sleep    2
    Select From List By Value    css:select.form-control    consult
    Select Checkbox    id:terms
    Checkbox Should Be Selected    id:terms
    Click Button    id:signInBtn
