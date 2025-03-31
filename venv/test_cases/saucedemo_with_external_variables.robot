*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/resources_saucedemo_with_external_variables.robot
Variables    ../resources/variables.py

*** Test Cases ***
Log In With Standard User
    [Setup]    Open Browser And Maximize   ${url}    ${browser_name}
    [Teardown]    Close Browser Window And Log
    sleep    2
    # input text will find element and insert text into it
    sleep    2
    Attempt To Login To Website    ${standard_user}    ${password}
    Successfull Login To Website
    ${Title}=    get title
    log    Page titlr is:${Title}
    ${Location}=    get location
    log    ${Location}
    ${Cookies}=    get cookies
    log    ${Cookies}
    wait until element is visible    xpath://*[@id="page_wrapper"]/footer/div
    scroll element into view    xpath://*[@id="page_wrapper"]/footer/div
    set screenshot directory    ../sreenshots
    capture page screenshot
    capture element screenshot    xpath://*[@id="item_3_img_link"]/img
    sleep    2
    Change Sorting Method    ${sort_hilo}
    Logout From Website

    sleep    2
    Attempt To Login To Website    ${problem_user}    ${password}
    sleep    2
    Successfull Login To Website
    sleep    2
    capture element screenshot    xpath://*[@id="item_1_img_link"]/img
    go back
    sleep    2

    input text    id:user-name    alla
    input password    id:password    alla555
    sleep    2
    # clear element text will clear a textfield
    clear element text    name:user-name
    clear element text    id:password
    sleep    2
    Attempt To Login To Website    ${locked_out_user}    ${password}
    sleep    2
    Unsuccessfull Login To Website
    sleep    2