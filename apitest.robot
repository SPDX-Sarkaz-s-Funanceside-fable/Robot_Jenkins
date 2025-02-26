*** Settings ***
Library    RequestsLibrary
Test Setup     Create Session    plus_api    ${BASE_URL}

*** Variables ***
${BASE_URL}    http://127.0.0.1:5000

*** Test Cases ***
Test Normal Addition
    ${response}    GET On Session    plus_api    /plus/4/5
    Status Should Be    200    ${response}
    Should Be Equal As Numbers   ${response.json()["Result is"]}    9

Test Factorial
    ${response}    GET On Session    plus_api    /factorial/7
    Status Should Be    200    ${response}
    Should Be Equal As Numbers   ${response.json()["Result is"]}    5040

Test Decimal
    ${response}    GET On Session    plus_api     /plus/5/6
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    11     ${response.json()["Result is"]}

Test Special Characters
    ${response}=     GET On Session    plus_api    /plus/100/a    expected_status=404
    Status Should Be    404             ${response}

Test Large integer
    ${response}    GET On Session    plus_api    /plus/2948939849/2424124124
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    5373063973    ${response.json()["Result is"]}


Test Below Zero
    ${response}    GET On Session    plus_api    /plus/-500/-300
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    -800    ${response.json()["Result is"]}

Test Positive int and Negative int
    ${response}    GET On Session    plus_api     /plus/-500/100
    Status Should Be    200     ${response}
    Should Be Equal As Numbers    -400    ${response.json()["Result is"]}

Test When x is 17
    ${response}  GET On Session  plus_api  /is_prime/17
    Should Be Equal    ${response.content.decode("utf-8")}    True

Test When x is 36
    ${response}  GET On Session  plus_api   /is_prime/36 
    Should Be Equal    ${response.content.decode("utf-8")}    False

Test When x is abba
    ${response}  GET On Session  plus_api   /palindrome/abba
    Should Be Equal    ${response.content.decode("utf-8")}    True

Test Ascii
    ${response}    GET On Session    plus_api    /Ascii/A
    Status Should Be    200    ${response}
    Should Be Equal As Numbers   ${response.json()["Result is"]}    65

Test SameChar_abc
    ${response}    GET On Session    plus_api    /samechar/abc
    Status Should Be    200    ${response}
    Should Be Equal   ${response.content.decode("utf-8")}    True

Test SameChar_abbc
    ${response}    GET On Session    plus_api    /samechar/abbc
    Status Should Be    200    ${response}
    Should Be Equal   ${response.content.decode("utf-8")}    False

Test minus integer
    ${response}    GET On Session    plus_api    /minus/7/4
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    3    ${response.json()["Result is"]}

Test When x is 2
    ${response}  GET On Session  plus_api  /is_even/2
    Should Be Equal    ${response.content.decode("utf-8")}    True

Test When x is 3
    ${response}  GET On Session  plus_api  /is_even/3
    Should Be Equal    ${response.content.decode("utf-8")}    False

Test odd When x is 2
    ${response}  GET On Session  plus_api  /is_odd/2
    Status Should Be    200    ${response}
    Should Be Equal    ${response.content.decode("utf-8")}    False

Test odd When x is 3
    ${response}  GET On Session  plus_api  /is_odd/3
    Status Should Be    200    ${response}
    Should Be Equal    ${response.content.decode("utf-8")}    True


Test multiple integer
    ${response}    GET On Session    plus_api    /multiple/7/3
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    21    ${response.json()["Result is"]}

Test divided interger
    ${response}    GET On Session    plus_api    /divide/4/2
    Status Should Be    200    ${response}
    Should Be Equal As Numbers    2    ${response.json()["Result is"]}