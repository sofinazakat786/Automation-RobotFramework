*** Settings ***
Documentation    To Validate the login form
Library    SeleniumLibrary
Test Setup    Open The Browser With Mortgage Payment URL
Test Teardown    Close Browser session
Resource    resource.robot


*** Variables ***
${Error_Message_Login}    css:.alert-danger

*** Test Cases ***
Validate Unsuccessful Login
    
    Fill the login form
    Wait until it checks and displays error message
    Verify error message is correct

*** Keywords ***


Fill the login form
    Input Text    id:username     ${user_name} 
    Input Password    id:password    ${invalid_password}
    Click Button    id:signInBtn


Wait until it checks and displays error message
    Wait Until Element Is Visible    ${Error_Message_Login}

Verify error message is correct
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.