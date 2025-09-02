*** Settings ***
Documentation       To Validate the login form

Library             SeleniumLibrary
Resource            resource.robot

Test Teardown       Close Browser Session


*** Variables ***
${SHOP_PAGE_LOAD}       css:.nav-link


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    Validates that login fails with invalid credentials and displays the correct error message.
    Open The Browser With Mortgage Payment URL
    Fill The Login Form    ${user_name}    ${invalid_password}
    Wait Until Element Is Located In The Page    ${Error_Message_Login}
    Verify Error Message Is Correct

Validate Cards Displayed In The Shopping Page
    [Documentation]    Validates that cards are displayed correctly in the shopping page after successful login.
    Open The Browser With Mortgage Payment URL
    Fill The Login Form    ${user_name}    ${valid_password}
    Wait Until Element Is Located In The Page    ${shop_page_load}
    Verify Card Titles In The Shop Page


*** Keywords ***
Verify Card Titles In The Shop Page
    [Documentation]    Verifies that the card titles are displayed correctly in the shop page.
    # @{expectedList} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}    Get WebElements    css:.card-title
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
    END
