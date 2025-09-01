*** Settings ***
Documentation    To Validate the login form
Library    SeleniumLibrary
Resource    resource.robot
Test Teardown    Close Browser session

*** Variables ***
${shop_page_load}    css:.nav-link


*** Test Cases ***
# Validate Unsuccessful Login
#     Open The Browser With Mortgage Payment URL
#     Fill the login form    ${user_name}    ${invalid_password}
#     Wait Until Element Is located in the page    ${Error_Message_Login}
#     Verify error message is correct

Validate Cards displayed in the Shopping Page
    Open The Browser With Mortgage Payment URL
    Fill the login form    ${user_name}    ${valid_password}
    Wait Until Element Is located in the page    ${shop_page_load}
    Verify Card Titles in the shop page


*** Keywords ***
Verify Card Titles in the shop page
    @{expectedList} =     Create List    iphone X    Samsung Note 8   Nokia Edge    Blackberry
    ${elements}    Get WebElements    css:.card-title
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
    END