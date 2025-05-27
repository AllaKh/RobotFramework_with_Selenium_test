*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/resources_saucedemo_chrome.robot
Variables    ../resources/variables.py

*** Variables ***
#Users
${StandardUser}    standard_user
${Password}    secret_sauce

${chrome_options}  add_experimental_option("prefs", {"credentials_enable_service": False, "profile.password_manager_enabled": False})

*** Test Cases ***
Log In With Different Users
    [Setup]    Open Browser And Maximize   ${url}    ${browser_name}    options=${chrome_options}
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
            Wait Until Element Is Visible    xpath://*[@id="page_wrapper"]/footer/div
            Scroll Element Into View    xpath://*[@id="page_wrapper"]/footer/div
            Capture Page Screenshot
            Capture Element Screenshot    xpath://*[@id="item_3_img_link"]/img
            sleep    5
            Logout From Website
        END
    END

Add Product To Cart and Check Out
    [Setup]    Open Browser And Maximize   ${url}    ${browser_name}    options=${chrome_options}
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
    END
    Add Product To Cart    //*[@id="item_4_title_link"]/div    //*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div    id:add-to-cart-sauce-labs-backpack
    wait until element is visible    id:remove-sauce-labs-backpack
    page should contain element    id:remove-sauce-labs-backpack
    Open Shoping Cart
    Checkout Shopping Cart    ${first_name}    ${last_name}    ${zip}
    sleep    2