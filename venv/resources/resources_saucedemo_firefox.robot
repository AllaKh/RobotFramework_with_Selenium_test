** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser and Maximize
    [Arguments]    ${user_url}    ${user_browser}
    open browser    ${user_url}    ${user_browser}
    maximize browser window
    log    Starting test in ${user_browser}
    log    Test URL: ${user_url}

Close Browser Window And Log
    log    Finishing test.
    close browser

Attempt To Login To Website
    [Arguments]    ${user_name}    ${user_password}
    log    Attempting login with username: ${user_name} and password: ${user_password}
    # input text will find element and insert text into it
    input text    id:user-name    ${user_name}
    input password    id:password    ${user_password}
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
    log    Logget out from webpage

Change Sorting Method
    [Arguments]    ${sorting_method}
    select from list by value    xpath://*[@id="header_container"]/div[2]/div/span/select    ${sorting_method}
    sleep    5

Add Product To Cart
    [Arguments]    ${product_id}    ${product_price_id}    ${add_btn_id}
    ${product_name}=    get text    xpath:${product_id}
    ${product_price}=    get text    xpath:${product_price_id}
    log    Product name: ${product_name}
    log    Product price: ${product_price}
    click button    ${add_btn_id}

Open Shoping Cart
    click link    xpath://*[@id="shopping_cart_container"]/a
    set screenshot directory    ../screenshots_cart
    capture element screenshot    xpath://*[@id="cart_contents_container"]/div/div[1]

Checkout Shopping Cart
    [Arguments]    ${user_first_mane}    ${user_last_name}    ${user_zip}
    click button    id:checkout
    input text    id:first-name    ${user_first_mane}
    input text    id:last-name    ${user_last_name}
    input text    id:postal-code    ${user_zip}
    sleep    3
    click button    id:continue
    capture element screenshot    xpath://*[@id="checkout_summary_container"]/div/div[2]
    click button    id:finish
    page should contain    Thank you for your order!
    click button    id:back-to-products