*** Settings ***
Documentation    A resource file with reusable keywords and variables
Library    SeleniumLibrary

*** Variables ***
${user_name}           rahulshettyacademy
${invalid_password}    xyz
${valid_password}      learning
${Error_Message_Login}    css:.alert-danger

*** Keywords ***
Open The Browser With Mortgage Payment URL
    Create WebDriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/
    Maximize Browser Window
    Sleep    2

Fill the login form
    [Arguments]    ${user_name}    ${password}
    Input Text    id:username     ${user_name}
    Input Password    id:password    ${password}
    Click Button    id:signInBtn


Wait Until Element Is located in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

Verify error message is correct
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.

Close Browser session
    Close Browser
