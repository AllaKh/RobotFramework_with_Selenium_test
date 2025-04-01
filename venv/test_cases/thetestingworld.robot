# Settings tab is used to add libraries, resources etc
*** Settings ***
Library    SeleniumLibrary

# Set of variables
*** Variables ***
${URL}    https://www.thetestingworld.com/testings
${Browser}    Chrome

# List of test cases
*** Test Cases ***
My First Test Case
    # open browser will open given browser and url
    Open Browser And Maximize   ${URL}  ${Browser}

    # input text will find element and insert text into it
    input text    name:fld_username    TestName
    input text    xpath://*[@id="tab-content1"]/form/input[3]    test_mail@example.com
    input password    xpath:/html/body/div[4]/section/ul/li[1]/div/form/input[4]    alla555
    input text    xpath://*[@id="tab-content1"]/form/input[5]   alla555

    # select radio button need two arguments [name, value]
    select radio button    add_type    office

    # checkbox can be selected with only one argument
    select checkbox    name:terms

    unselect checkbox    name:terms

    # click commands need only locator as an argument
    click link    xpath://*[@id="tab-content1"]/form/div/em/a
    click link    xpath://*[@id="popup1"]/a
    click button    xpath://*[@id="tab-content1"]/form/div/input[2]

    # close browser will close browser window
    close browser