*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/resources_saucedemo_firefox.robot
Variables    ../resources/variables.py

*** Variables ***
#Users
${StandardUser}    standard_user
${Password}    secret_sauce

*** Test Cases ***
Log In With Different Users
    [Setup]    Open Browser And Maximize   ${url}    ${browser_name}
    [Teardown]    Close Browser Window And Log
    sleep    2
    # input text will find element and insert text into it
    input text    id:user-name    alla
    input password    id:password    alla555
    sleep    2
    # clear element text will clear a textfield
    clear element text    name:user-name
    clear element text    id:password
    sleep    2
    FOR    ${user}    IN    @{user_names}
        Log    Attempting to log in with ${user}
        Attempt To Login To Website    ${user}    ${password}
        IF    '${user}' == 'locked_out_user'
            Unsuccessfull Login To Website
        ELSE
            Successfull Login To Website
            ${Title}=    Get Title
            Log    Page title is: ${Title}
            ${Location}=    Get Location
            Log    ${Location}
            ${Cookies}=    Get Cookies
            Log    ${Cookies}
            Wait Until Element Is Visible    xpath:/html/body/div/div/footer/div
            Capture Page Screenshot
            Capture Element Screenshot    xpath:/html/body/div/div/div/div[2]/div/div/div/div[6]/div[1]/a/img
            sleep    5
            Logout From Website
        END
    END

Add Product To Cart and Check Out
    [Setup]    Open Browser And Maximize   ${url}    ${browser_name}
    [Teardown]    Close Browser Window And Log
    sleep    2
    # input text will find element and insert text into it
    sleep    2
    input text    id:user-name    ${StandardUser}
    input password    id:password    ${Password}
    click button    id:login-button
    sleep    2
    Successfull Login To Website
    sleep    2
    FOR    ${sort_order}    IN    @{sort_method}
        Change Sorting Method    ${sort_order}
#        sleep    1
    END
    Add Product To Cart    //*[@id="item_4_title_link"]/div    //*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div    id:add-to-cart-sauce-labs-backpack
    wait until element is visible    id:remove-sauce-labs-backpack
    page should contain element    id:remove-sauce-labs-backpack
    Open Shoping Cart
    Checkout Shopping Cart    ${first_name}    ${last_name}    ${zip}
    sleep    2