*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser And Maximize
    [Arguments]    ${UserURL}    ${BrowserName}
    open browser    ${UserURL}    ${BrowserName}
    maximize browser window

Login To Website
    [Arguments]    ${Username}    ${Password}
    input text    name:user-name    ${Username}
    input password    xpath://*[@id="password"]    ${Password}
    click button    name:login-button

Close Browser Window
    ${Title}=    get title
    Log    ${Title}
    close browser