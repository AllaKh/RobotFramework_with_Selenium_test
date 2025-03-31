# Settings tab is used to add libraries, resources etc
*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/resources.robot

# Set of variables
*** Variables ***
${URL}    http://www.saucedemo.com
${Browser}    Chrome

#Users
${StandardUser}    standard_user
${LockedOutUser}    locked_out_user
${ProblemUser}    problem_user
${PerformanceGlitchUser}    performance_glitch_user
${ErrorUser}    error_user
${VisualUser}    visual_user

${Password}    secret_sauce

# List of test cases
*** Test Cases ***
Log In With Standard User
    # open browser will open given browser and url
    Open Browser And Maximize   ${URL}  ${Browser}
    sleep    2
    # input text will find element and insert text into it
    input text    id:user-name    standard_user
    sleep    2
    # clear element text will clear a textfield
    clear element text    name:user-name
    sleep    2
    Login To Website    ${StandardUser}    ${Password}
    page should not contain element    class:error-message-container
    element should contain    class:inventory_item_name    Sauce Labs Backpack
    # backspace
    go back
    sleep    2
    Close Browser Window

Log In With LockedOutUser User
    # open browser will open given browser and url
    Open Browser And Maximize   ${URL}  ${Browser}
    sleep    2
    Login To Website    ${LockedOutUser}    ${Password}
    sleep    2
    page should contain element    class:error-message-container
    Close Browser Window

Log In With ProblemUser User
    # open browser will open given browser and url
    Open Browser And Maximize   ${URL}  ${Browser}
    sleep    2
    Login To Website    ${ProblemUser}    ${Password}
    sleep    2
    page should not contain element    class:error-message-container
    element should contain    class:inventory_item_name    Sauce Labs Backpack
    Close Browser Window

#*** Keywords ***
#Open Browser and Maximize
#    open browser    ${URL}    ${Browser}
#    maximize browser window