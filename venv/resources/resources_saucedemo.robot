*** Settings ***
Library    SeleniumLibrary

*** Variables ***


*** Keywords ***
Open Browser and Maximize
    [Arguments]    ${WebsiteUrl}    ${BrowserName}
#    log    Starting test with ${BrowserName} on ${WebsiteUrl}
    open browser    ${WebsiteUrl}    ${BrowserName}
    maximize browser window
    log    Starting test with ${BrowserName}
    log    Test URL: ${WebsiteUrl}

Close Browser Window
    log    Finishing test.
    close browser

Attempt To Login To Website
    [Arguments]    ${UserName}    ${Password}
    log    Attempting login with username: ${UserName} and password: ${Password}
    # input text will find element and insert text into it
    input text    id:user-name    ${UserName}
    input password    id:password    ${Password}
    sleep    2
    click button    id:login-button

Successfull Login To Website
#    page should not contain element    xpath://*[@id="login_button_container"]/div/form/div[3]/h3
    page should not contain element    class:error-message-container
    element should contain    class:inventory_item_name    Sauce Labs Backpack
    location should be   https://www.saucedemo.com/inventory.html

Unsuccessfull Login To Website
    page should contain element    class:error-message-container

Logout From Website
    log    Logout attempt
    click button    id:react-burger-menu-btn
    wait until element is visible    id:logout_sidebar_link
    click link    id:logout_sidebar_link

Add Product To Cart
    [Arguments]    ${ProductNameIdentifier}    ${ButtonIdentifier}
    ${Product}=    get text    ${ProductNameIdentifier}
    log    ${Product}
    click button    ${ButtonIdentifier}

Change Sorting Method
    [Arguments]    ${SortingMethod}
    select from list by value    xpath://*[@id="header_container"]/div[2]/div[2]/span/select    ${SortingMethod}

Checkout Shopping Cart
    [Arguments]    ${FirstName}    ${LastName}    ${ZIP}    ${CheckSum}
    click link    xpath://*[@id="shopping_cart_container"]/a
    set screenshot directory    screenshots
    capture element screenshot    xpath://*[@id="cart_contents_container"]/div/div[1]
    click button    id:checkout
    input text    id:first-name    ${FirstName}
    input text    id:last-name    ${LastName}
    input text    id:postal-code    ${ZIP}
    sleep    5
    click button    id:continue
    scroll element into view    id:finish
    capture element screenshot    xpath://*[@id="checkout_summary_container"]/div/div[2]
    element should contain    xpath://*[@id="checkout_summary_container"]/div/div[2]/div[7]    ${CheckSum}
    ${Price}=    get text    xpath://*[@id="checkout_summary_container"]/div/div[2]/div[7]
    log    ${Price}
    click button    id:finish
    click button    id:back-to-products